import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/footer_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/recording_voice_widgets/user_recorded_list.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/shadowing_player.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:record/record.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    as yt_player;

import '../../bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import 'dialogs/save_recording_dialog.dart';
import 'model/subtitle_line.dart';
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
  late yt_player.YoutubePlayerController _controller;
  late final PageController _pageController;
  Duration _position = Duration.zero;

  final _userRecordedSentenceAudioBloc = UserRecordedSentenceAudioBloc();

  Future<List<SubtitleLine>> loadSubtitles() async {
    final jsonString =
        await rootBundle.loadString("assets/subtitles/shadowing.json");
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => SubtitleLine.fromJson(e)).toList();
  }

  bool _backPressed = false;

  int _currentPage = 0;

  String newVoiceName = "Voice_001";
  late final ValueNotifier<int> _recordDurationNotifier;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  late ValueNotifier<RecordState> _recordStateNotifier;
  StreamSubscription<RecordState>? _recordSub;

  late AudioPlayer _audioPlayer;
  late final ValueNotifier<int?> _currentlyPlayingIndexNotifier;
  final _subtitleDetailBloc = SubtitleBloc();

  Duration _startDuration = Duration.zero;
  Duration _endDuration = Duration.zero;
  bool _needSeek = true;

  @override
  void initState() {
    super.initState();

    _recordDurationNotifier = ValueNotifier<int>(0);
    _recordStateNotifier = ValueNotifier<RecordState>(RecordState.stop);

    _audioRecorder = AudioRecorder();
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordStateNotifier.value = recordState);
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
    // Reset when audio completes
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _currentlyPlayingIndexNotifier.value = null;
        });
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
        if (mounted) {
          setState(() {
            _position = _controller.value.position;
            if (_position.inMilliseconds > _endDuration.inMilliseconds) {
              _controller.pause();
              _needSeek = true;
            }
          });
        }
      });
    _userRecordedSentenceAudioBloc.add(
      const UserRecordedSentenceAudioEvent.load(
        withLoading: true,
      ),
    );
    _subtitleDetailBloc.add(
      SubtitleEvent.parseRecordSubtitle(widget.listening),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _recordSub?.cancel();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _subtitleDetailBloc.close();
    super.dispose();
  }

  bool _isRecording() {
    return _recordStateNotifier.value == RecordState.record;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        int recordDuration = _recordDurationNotifier.value;
        recordDuration++;
        _recordDurationNotifier.value = recordDuration;
      });
    });
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
              ? const MainScaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : MainScaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF0F2027),
                    title: const Text(
                      "Speech Practice Session",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: BlocConsumer<SubtitleBloc, SubtitleState>(
                    bloc: _subtitleDetailBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        onRecordSubtitleCompleted: (recordSubtitles) {
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
                      return state.maybeWhen(
                        loading: (message) {
                          return const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        onRecordSubtitleCompleted: (recordSubtitles) {
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
                                        color: PmpColors.primary400
                                            .withValues(alpha: 0.15),
                                      ),
                                      child: const Icon(
                                        Icons.mic_none,
                                        size: 48,
                                        color: PmpColors.primary400,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Coming Soon",
                                      style: PmpTextStyles.h1.copyWith(
                                        color: PmpColors.white,
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
                                        color: PmpColors.white
                                            .withValues(alpha: 0.75),
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
                                position: _position,
                                totalDuration:
                                    Duration(seconds: widget.listening.end),
                                onTogglePlay: () {
                                  final loading =
                                      _controller.value.playerState ==
                                              yt_player.PlayerState.buffering ||
                                          !_controller.value.isReady;
                                  if (loading) {
                                    return;
                                  }
                                  if (_isRecording()) {
                                    ScaffoldMessenger.of(context)
                                      ..clearSnackBars()
                                      ..showSnackBar(const SnackBar(
                                        content: Text(
                                          "Playback is disabled while recording. Please stop the recording to continue.",
                                          style: TextStyle(
                                            color: PmpColors.white,
                                          ),
                                        ),
                                        backgroundColor: Colors.green,
                                        closeIconColor: PmpColors.white,
                                        showCloseIcon: true,
                                      ));
                                    return;
                                  }
                                  if (_audioPlayer.playing) {
                                    _audioPlayer.pause();
                                  }
                                  if (_controller.value.playerState ==
                                      yt_player.PlayerState.ended) {
                                    _controller.seekTo(Duration.zero);
                                    _controller.play();
                                  } else if (_controller.value.isPlaying) {
                                    _needSeek = false;
                                    _controller.pause();
                                  } else {
                                    if (_needSeek) {
                                      _controller.seekTo(Duration(
                                          milliseconds:
                                              _startDuration.inMilliseconds));
                                    }
                                    _controller.play();
                                  }
                                },
                              ),
                              // const SizedBox(height: 16),
                              SizedBox(
                                height: 240,
                                child: PageView.builder(
                                  itemCount: recordSubtitles.length,
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: (index) {
                                    // _controller.load(_subtitles[index].videoId);
                                  },
                                  itemBuilder: (context, index) {
                                    final subtitle = recordSubtitles[index];
                                    return Scrollbar(
                                      thumbVisibility: true,
                                      radius: const Radius.circular(8),
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: subtitle.data.map(
                                              (item) {
                                                final isCurrent = _position
                                                            .inMilliseconds >=
                                                        (item.start * 1000)
                                                            .round() &&
                                                    _position.inMilliseconds <
                                                        (item.end * 1000)
                                                            .round();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 8.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "-",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          height: 1.4,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "ArchivoBlack Regular",
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          item.text,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            height: 1.4,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: isCurrent
                                                                ? Colors.yellow
                                                                : Colors.white,
                                                            fontFamily:
                                                                "ArchivoBlack Regular",
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ).toList()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ValueListenableBuilder<RecordState>(
                                  valueListenable: _recordStateNotifier,
                                  builder: (context, recordState, child) {
                                    return ValueListenableBuilder<int>(
                                        valueListenable:
                                            _recordDurationNotifier,
                                        builder:
                                            (context, recordDuration, child) {
                                          return Recorder(
                                            recordState: recordState,
                                            recordDuration: recordDuration,
                                            audioRecorder: _audioRecorder,
                                            onStart: () {
                                              if (_controller.value.isPlaying) {
                                                _controller.pause();
                                              }
                                              if (_audioPlayer.playing) {
                                                _audioPlayer.pause();
                                              }
                                            },
                                            onStop: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  final sentenceId =
                                                      recordSubtitles[
                                                              _currentPage]
                                                          .id;
                                                  return SaveRecordingDialog(
                                                    sentenceId: sentenceId,
                                                    youtubeId: widget
                                                        .listening.youtubeId,
                                                    audioName: newVoiceName,
                                                    audioRecorder:
                                                        _audioRecorder,
                                                    onDiscard: () async {
                                                      try {
                                                        // Stop recording and get the file path
                                                        final filePath =
                                                            await _audioRecorder
                                                                .stop();
                                                        if (filePath != null) {
                                                          final file =
                                                              File(filePath);
                                                          if (await file
                                                              .exists()) {
                                                            await file.delete();
                                                            debugPrint(
                                                                '_userDiscardedAudio: Deleted discarded audio file: $filePath');
                                                          } else {
                                                            debugPrint(
                                                                '_userDiscardedAudio: No file found to delete at $filePath');
                                                          }
                                                        }
                                                      } catch (e) {
                                                        debugPrint(
                                                            '_userDiscardedAudio: Error deleting discarded audio: $e');
                                                      }
                                                    },
                                                    onSaved: (success) {
                                                      if (success) {
                                                        _userRecordedSentenceAudioBloc
                                                            .add(
                                                          const UserRecordedSentenceAudioEvent
                                                              .load(
                                                              withLoading:
                                                                  false),
                                                        );
                                                      }
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        });
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color:
                                            Colors.white.withValues(alpha: 0.2),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                    const Text(
                                      "Records",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "ArchivoBlack Regular",
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color:
                                            Colors.white.withValues(alpha: 0.2),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ValueListenableBuilder<int?>(
                                    valueListenable:
                                        _currentlyPlayingIndexNotifier,
                                    builder: (context, currentIndex, child) {
                                      return UserRecordedList(
                                        audioPlayer: _audioPlayer,
                                        currentIndex: currentIndex,
                                        userRecordedSentenceAudioBloc:
                                            _userRecordedSentenceAudioBloc,
                                        onNewVoiceName: (name) {
                                          newVoiceName = name;
                                        },
                                        sentenceId:
                                            recordSubtitles[_currentPage].id,
                                        youtubeId: widget.listening.youtubeId,
                                        onTogglePlay: (data, index) async {
                                          if (_isRecording()) {
                                            ScaffoldMessenger.of(context)
                                              ..clearSnackBars()
                                              ..showSnackBar(const SnackBar(
                                                content: Text(
                                                  "Playback is disabled while recording. Please stop the recording to continue.",
                                                  style: TextStyle(
                                                    color: PmpColors.white,
                                                  ),
                                                ),
                                                backgroundColor: Colors.green,
                                                closeIconColor: PmpColors.white,
                                                showCloseIcon: true,
                                              ));
                                            return;
                                          }
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          }
                                          final isCurrent =
                                              currentIndex == index;
                                          if (isCurrent) {
                                            // toggle pause / resume
                                            if (_audioPlayer.playing) {
                                              _audioPlayer.pause();
                                              _currentlyPlayingIndexNotifier
                                                  .value = null;
                                            } else {
                                              _audioPlayer.play();
                                              setState(() {
                                                _currentlyPlayingIndexNotifier
                                                    .value = index;
                                              });
                                            }
                                            setState(() {}); // refresh icon
                                          } else {
                                            // stop previous
                                            await _audioPlayer.stop();
                                            await _audioPlayer.setUrl(data
                                                .audioPath); // play new audio
                                            _audioPlayer.play();
                                            setState(() {
                                              _currentlyPlayingIndexNotifier
                                                  .value = index;
                                            });
                                          }
                                        },
                                      );
                                    }),
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
                                  _pageController.jumpToPage(index);
                                  setState(
                                    () => _currentPage = index,
                                  );
                                },
                                nextEnabled: true,
                              )
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
