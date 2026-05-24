import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/listening/record_subtitle_bloc.dart';
import 'package:pmp_english/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/video_step_progress/video_step_progress.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/footer_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/recording_voice_widgets/user_recorded_list.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/shadowing_player.dart';
import 'package:record/record.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    as yt_player;

import '../../bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import 'dialogs/save_recording_dialog.dart';
import 'recording_voice_widgets/recorder.dart';

class SpeechPracticeSessionPage extends StatefulWidget {
  const SpeechPracticeSessionPage({
    super.key,
    required this.listening,
  });

  final Listening listening;

  @override
  State<SpeechPracticeSessionPage> createState() =>
      _SpeechPracticeSessionPageState();
}

class _SpeechPracticeSessionPageState extends State<SpeechPracticeSessionPage> {
  static const double _kRecorderHeight = 52.0;
  static const double _kHandleHeight = 40.0;
  static const double _kMinProportion = 0.15;
  static const double _kMaxProportion = 0.85;

  late yt_player.YoutubePlayerController _controller;
  late final PageController _pageController;
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);
  final ValueNotifier<double> _splitProportionNotifier =
      ValueNotifier(0.6);

  final _userRecordedSentenceAudioBloc = UserRecordedSentenceAudioBloc();

  bool _backPressed = false;

  int _currentPage = 0;

  String newVoiceName = "Voice_001";
  late final ValueNotifier<int> _recordDurationNotifier;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  late ValueNotifier<RecordState> _recordStateNotifier;
  StreamSubscription<RecordState>? _recordSub;
  StreamSubscription? _playerStateSub;

  late AudioPlayer _audioPlayer;
  late final ValueNotifier<int?> _currentlyPlayingIndexNotifier;
  final _recordSubtitleBloc = RecordSubtitleBloc();

  Duration _startDuration = Duration.zero;
  Duration _endDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    _recordDurationNotifier = ValueNotifier<int>(0);
    _recordStateNotifier = ValueNotifier<RecordState>(RecordState.stop);

    _audioRecorder = AudioRecorder();
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _recordStateNotifier.value = recordState;
      if (recordState == RecordState.record) {
        _startTimer();
      } else if (recordState == RecordState.stop) {
        _timer?.cancel();
        _recordDurationNotifier.value = 0;
      } else if (recordState == RecordState.pause) {
        _timer?.cancel();
      }
    });

    _audioPlayer = AudioPlayer();
    _currentlyPlayingIndexNotifier = ValueNotifier<int?>(null);
    _playerStateSub = _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _currentlyPlayingIndexNotifier.value = null;
      }
    });

    _pageController = PageController(initialPage: _currentPage);
    _controller = yt_player.YoutubePlayerController(
      initialVideoId: widget.listening.youtubeId,
      flags: const yt_player.YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
      ),
    )..addListener(() {
        if (!mounted) return;
        final pos = _controller.value.position;
        _positionNotifier.value = pos;
        if (pos.inMilliseconds > _endDuration.inMilliseconds) {
          _controller.pause();
        }
      });
    _userRecordedSentenceAudioBloc.add(
      const UserRecordedSentenceAudioEvent.load(
        withLoading: true,
      ),
    );
    _recordSubtitleBloc.add(
      RecordSubtitleEvent.parse(widget.listening),
    );

    context.read<VideoStepProgressBloc>().add(
          VideoStepProgressEvent.markInProgress(
            widget.listening.youtubeId,
            VideoLessonStep.record,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _recordSub?.cancel();
    _playerStateSub?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _recordSubtitleBloc.close();
    _userRecordedSentenceAudioBloc.close();
    _positionNotifier.dispose();
    _splitProportionNotifier.dispose();
    _recordDurationNotifier.dispose();
    _recordStateNotifier.dispose();
    _currentlyPlayingIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool _isRecording() {
    return _recordStateNotifier.value == RecordState.record;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDurationNotifier.value = _recordDurationNotifier.value + 1;
    });
  }

  void _showRecordingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(const SnackBar(
        content: Text(
          "Playback is disabled while recording. Please stop the recording to continue.",
          style: TextStyle(color: PmpColors.white),
        ),
        backgroundColor: Colors.green,
        closeIconColor: PmpColors.white,
        showCloseIcon: true,
      ));
  }

  Widget _buildDragHandle(ColorScheme colorScheme, double usableHeight) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (details) {
        final delta = details.delta.dy / usableHeight;
        _splitProportionNotifier.value =
            (_splitProportionNotifier.value + delta)
                .clamp(_kMinProportion, _kMaxProportion);
      },
      child: SizedBox(
        height: _kHandleHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: colorScheme.outlineVariant,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                Text(
                  "Records",
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: colorScheme.outlineVariant,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        Future.delayed(const Duration(milliseconds: 300), () {
          if (context.mounted) Navigator.of(context).pop();
        });
        setState(() {
          _backPressed = true;
        });
      },
      child: yt_player.YoutubePlayerBuilder(
        player: yt_player.YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return _backPressed
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: const Text("Speech Practice Session"),
                  ),
                  body: BlocConsumer<RecordSubtitleBloc, RecordSubtitleState>(
                    bloc: _recordSubtitleBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        loaded: (recordSubtitles) {
                          if (recordSubtitles.isEmpty) return;
                          _startDuration = Duration(
                            milliseconds:
                                (recordSubtitles.first.start * 1000).round(),
                          );
                          _endDuration = Duration(
                            milliseconds:
                                (recordSubtitles.first.end * 1000).round(),
                          );
                        },
                        orElse: () => -1,
                      );
                    },
                    builder: (context, state) {
                      final colorScheme = Theme.of(context).colorScheme;
                      return state.maybeWhen(
                        loading: () {
                          return const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        loaded: (recordSubtitles) {
                          if (recordSubtitles.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorScheme.onSurface
                                            .withValues(alpha: 0.08),
                                      ),
                                      child: Icon(
                                        Icons.mic_none,
                                        size: 48,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Coming Soon",
                                      style: PmpTextStyles.h1.copyWith(
                                        color: colorScheme.onSurface,
                                        fontFamily: 'ArchivoBlack Regular',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "We’re polishing the record subtitles to give you the best shadowing experience.\n"
                                      "Check back soon and get ready to practice!",
                                      style:
                                          PmpTextStyles.body2Regular.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              ShadowingPlayer(
                                listening: widget.listening,
                                controller: _controller,
                                player: player,
                                positionListenable: _positionNotifier,
                                totalDuration:
                                    Duration(seconds: widget.listening.end),
                                segmentStart: _startDuration,
                                segmentEnd: _endDuration,
                                onTogglePlay: () {
                                  final loading =
                                      _controller.value.playerState ==
                                              yt_player.PlayerState.buffering ||
                                          !_controller.value.isReady;
                                  if (loading) return;
                                  if (_isRecording()) {
                                    _showRecordingSnackBar(context);
                                    return;
                                  }
                                  if (_audioPlayer.playing) {
                                    _audioPlayer.pause();
                                  }
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.seekTo(_startDuration);
                                    _controller.play();
                                  }
                                },
                              ),
                              // Resizable split zone
                              Expanded(
                                child: ValueListenableBuilder<double>(
                                  valueListenable: _splitProportionNotifier,
                                  builder: (context, proportion, _) {
                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        final totalHeight =
                                            constraints.maxHeight;
                                        final usableHeight = totalHeight -
                                            _kRecorderHeight -
                                            _kHandleHeight;
                                        if (usableHeight <= 0) {
                                          return const SizedBox.shrink();
                                        }
                                        final topHeight =
                                            (usableHeight * proportion)
                                                .clamp(0.0, usableHeight);
                                        final bottomHeight =
                                            usableHeight - topHeight;

                                        return Column(
                                          children: [
                                            // Subtitle panel
                                            SizedBox(
                                              height: topHeight,
                                              child: PageView.builder(
                                                itemCount:
                                                    recordSubtitles.length,
                                                controller: _pageController,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  final subtitle =
                                                      recordSubtitles[index];
                                                  return Scrollbar(
                                                    thumbVisibility: true,
                                                    radius:
                                                        const Radius.circular(
                                                            8),
                                                    child:
                                                        SingleChildScrollView(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 16,
                                                      ),
                                                      child:
                                                          ValueListenableBuilder<
                                                              Duration>(
                                                        valueListenable:
                                                            _positionNotifier,
                                                        builder: (_,
                                                                position,
                                                                __) =>
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children:
                                                                    subtitle
                                                                        .data
                                                                        .map(
                                                                  (item) {
                                                                    final isCurrent = position.inMilliseconds >=
                                                                            (item.start * 1000)
                                                                                .round() &&
                                                                        position.inMilliseconds <
                                                                            (item.end * 1000).round();
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        bottom:
                                                                            8.0,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "-",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              height: 1.4,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: colorScheme.onSurface,
                                                                              fontFamily: "ArchivoBlack Regular",
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 4),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              item.text,
                                                                              style: TextStyle(
                                                                                fontSize: 16,
                                                                                height: 1.4,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: isCurrent ? PmpColors.warning400 : colorScheme.onSurface,
                                                                                fontFamily: "ArchivoBlack Regular",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ).toList()),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // Recorder (fixed)
                                            SizedBox(
                                              height: _kRecorderHeight,
                                              child:
                                                  ValueListenableBuilder<
                                                      RecordState>(
                                                valueListenable:
                                                    _recordStateNotifier,
                                                builder: (context,
                                                    recordState, child) {
                                                  return ValueListenableBuilder<
                                                      int>(
                                                    valueListenable:
                                                        _recordDurationNotifier,
                                                    builder: (context,
                                                        recordDuration,
                                                        child) {
                                                      return Recorder(
                                                        recordState:
                                                            recordState,
                                                        recordDuration:
                                                            recordDuration,
                                                        audioRecorder:
                                                            _audioRecorder,
                                                        onStart: () {
                                                          if (_controller
                                                              .value
                                                              .isPlaying) {
                                                            _controller
                                                                .pause();
                                                          }
                                                          if (_audioPlayer
                                                              .playing) {
                                                            _audioPlayer
                                                                .pause();
                                                          }
                                                        },
                                                        onStop: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) {
                                                              final sentenceId =
                                                                  recordSubtitles[
                                                                          _currentPage]
                                                                      .id;
                                                              return SaveRecordingDialog(
                                                                sentenceId:
                                                                    sentenceId,
                                                                youtubeId: widget
                                                                    .listening
                                                                    .youtubeId,
                                                                audioName:
                                                                    newVoiceName,
                                                                audioRecorder:
                                                                    _audioRecorder,
                                                                onDiscard:
                                                                    () async {
                                                                  try {
                                                                    final filePath =
                                                                        await _audioRecorder
                                                                            .stop();
                                                                    if (filePath !=
                                                                        null) {
                                                                      final file =
                                                                          File(filePath);
                                                                      if (await file
                                                                          .exists()) {
                                                                        await file
                                                                            .delete();
                                                                        AppLogger
                                                                            .instance
                                                                            .debug('_userDiscardedAudio: Deleted discarded audio file: $filePath');
                                                                      } else {
                                                                        AppLogger
                                                                            .instance
                                                                            .debug('_userDiscardedAudio: No file found to delete at $filePath');
                                                                      }
                                                                    }
                                                                  } catch (e) {
                                                                    AppLogger
                                                                        .instance
                                                                        .error(
                                                                      '_userDiscardedAudio: Error deleting discarded audio: $e',
                                                                      error:
                                                                          e,
                                                                    );
                                                                  }
                                                                },
                                                                onSaved:
                                                                    (success) {
                                                                  if (success) {
                                                                    _userRecordedSentenceAudioBloc
                                                                        .add(
                                                                      const UserRecordedSentenceAudioEvent
                                                                          .load(
                                                                        withLoading:
                                                                            false,
                                                                      ),
                                                                    );
                                                                    if (mounted) {
                                                                      context
                                                                          .read<
                                                                              VideoStepProgressBloc>()
                                                                          .add(
                                                                            VideoStepProgressEvent.markDone(
                                                                              widget.listening.youtubeId,
                                                                              VideoLessonStep.record,
                                                                            ),
                                                                          );
                                                                    }
                                                                  }
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            // Drag handle
                                            _buildDragHandle(
                                              colorScheme,
                                              usableHeight,
                                            ),
                                            // Recordings panel
                                            SizedBox(
                                              height: bottomHeight,
                                              child:
                                                  ValueListenableBuilder<int?>(
                                                valueListenable:
                                                    _currentlyPlayingIndexNotifier,
                                                builder: (context,
                                                    currentIndex, child) {
                                                  return UserRecordedList(
                                                    audioPlayer: _audioPlayer,
                                                    currentIndex:
                                                        currentIndex,
                                                    userRecordedSentenceAudioBloc:
                                                        _userRecordedSentenceAudioBloc,
                                                    onNewVoiceName: (name) {
                                                      newVoiceName = name;
                                                    },
                                                    sentenceId:
                                                        recordSubtitles[
                                                                _currentPage]
                                                            .id,
                                                    youtubeId: widget
                                                        .listening.youtubeId,
                                                    onTogglePlay:
                                                        (data, index) async {
                                                      if (_isRecording()) {
                                                        _showRecordingSnackBar(
                                                            context);
                                                        return;
                                                      }
                                                      if (_controller
                                                          .value.isPlaying) {
                                                        _controller.pause();
                                                      }
                                                      final isCurrent =
                                                          currentIndex ==
                                                              index;
                                                      if (isCurrent) {
                                                        if (_audioPlayer
                                                            .playing) {
                                                          _audioPlayer
                                                              .pause();
                                                          _currentlyPlayingIndexNotifier
                                                                  .value =
                                                              null;
                                                        } else {
                                                          _audioPlayer
                                                              .play();
                                                          _currentlyPlayingIndexNotifier
                                                                  .value =
                                                              index;
                                                        }
                                                      } else {
                                                        await _audioPlayer
                                                            .stop();
                                                        await _audioPlayer
                                                            .setUrl(data
                                                                .audioPath);
                                                        _audioPlayer.play();
                                                        _currentlyPlayingIndexNotifier
                                                                .value =
                                                            index;
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              FooterWidget(
                                totalPage: recordSubtitles.length,
                                currentPage: _currentPage,
                                onPageChanged: (index) {
                                  _audioPlayer.stop();
                                  _controller.pause();
                                  _startDuration = Duration(
                                      milliseconds:
                                          (recordSubtitles[index].start * 1000)
                                              .round());
                                  _endDuration = Duration(
                                    milliseconds:
                                        (recordSubtitles[index].end * 1000)
                                            .round(),
                                  );
                                  _controller.seekTo(_startDuration);
                                  _pageController.jumpToPage(index);
                                  setState(
                                    () => _currentPage = index,
                                  );
                                },
                                nextEnabled: true,
                              ),
                            ],
                          );
                        },
                        orElse: () => Container(),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
