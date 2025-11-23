import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/subtitle_detail_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/audio_player/audio_player_bloc.dart';
import '../../bloc/subtitle_detail/subtitle_detail_bloc.dart';

/// Homepage
class YoutubeVideoPage extends StatefulWidget {
  const YoutubeVideoPage({
    super.key,
    required this.listening,
  });
  final Listening listening;

  @override
  State<YoutubeVideoPage> createState() => _YoutubeVideoPageState();
}

class _YoutubeVideoPageState extends State<YoutubeVideoPage> {
  late YoutubePlayerController _controller;

  late final Duration _startDuration;
  late final Duration _endDuration;
  int sliderPosition = 0;
  final ScrollController _lyricsController = ScrollController();

  bool _readyToPlay = false;
  final List<Subtitle> _subtitles = [];
  bool _showLoadingLayout = false;

  final _subtitleBloc = SubtitleBloc();
  final _subtitleParsingBloc = SubtitleBloc();
  int _subtitlePageIndex = 0;

  final _audioPositionTrackerBloc = AudioPlayerBloc();
  final _audioDurationTrackerBloc = AudioPlayerBloc();
  final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
  final _audioPlayer = AudioPlayer();
  StreamSubscription? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSub;
  late final StreamSubscription<Duration?> _durationSub;

  double currentSpeed = 1.0;
  @override
  void initState() {
    super.initState();
    _startDuration = Duration(seconds: widget.listening.start);
    _endDuration = Duration(
      seconds: (widget.listening.end - widget.listening.start),
    );
    _controller = YoutubePlayerController(
      initialVideoId: widget.listening.youtubeId.trim(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        startAt: widget.listening.start,
        endAt: widget.listening.end,
        enableCaption: false,
        captionLanguage: 'mm',
        hideControls: true,
      ),
    )..addListener(listener);

    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      _audioPlayerStateTrackerBloc.add(
        AudioPlayerEvent.updatePlayerState(playerState),
      );
    });
    _positionSub = _audioPlayer.positionStream.listen(
      (pos) {
        _audioPositionTrackerBloc.add(AudioPlayerEvent.setCurrentPosition(pos));
      },
    );
    _durationSub = _audioPlayer.durationStream.listen(
      (duration) {
        if (duration == null) {
          return;
        }
        _audioDurationTrackerBloc
            .add(AudioPlayerEvent.setTotalDuration(duration));
        debugPrint("_durationSub: ${duration.inSeconds} inSeconds!");
      },
    );
    _subtitleParsingBloc.add(SubtitleEvent.parseSubtitle(widget.listening));
  }

  void listener() {
    if (_readyToPlay && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _updateCurrentSubtitleIndex();
      });
    }
  }

  // For Subtitle Detail Widget
  void _updateCurrentSubtitleIndex() {
    final position = _controller.value.position.inSeconds;

    final subtitle = _subtitles.firstWhere(
      (subtitle) =>
          position >= subtitle.start.inSeconds &&
          position < subtitle.end.inSeconds,
      orElse: () => Subtitle.empty(),
    );

    if (subtitle.isNotEmpty) {
      final newIndex = _subtitles.indexWhere((s) => s.id == subtitle.id);
      if (newIndex != _subtitlePageIndex) {
        _subtitlePageIndex = newIndex;
        debugPrint("_currentSubtitlePageIndex: $_subtitlePageIndex");
        _subtitleBloc.add(
          SubtitleEvent.setCurrentPageIndex(_subtitlePageIndex),
        );
      }
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    _playerStateSubscription?.cancel();
    _positionSub?.cancel();
    _audioPlayer.dispose();
    _durationSub.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _lyricsController.removeListener(listener);
    _lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _subtitleBloc,
        ),
        BlocProvider(
          create: (context) => _audioPositionTrackerBloc,
        ),
        BlocProvider(
          create: (context) => _audioDurationTrackerBloc,
        ),
        BlocProvider(
          create: (context) => _audioPlayerStateTrackerBloc,
        ),
        BlocProvider(
          create: (context) => _subtitleParsingBloc,
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) Navigator.of(context).pop();
          });
          setState(() {
            _showLoadingLayout = true;
          });
        },
        child: _showLoadingLayout
            ? const MainScaffold(
                body: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : BlocConsumer<SubtitleBloc, SubtitleState>(
                bloc: _subtitleParsingBloc,
                listener: (context, state) {
                  state.maybeWhen(
                    onParseCompleted: (subtitles) {
                      if (_subtitles.isEmpty) {
                        _subtitles.addAll(subtitles);
                      }
                    },
                    orElse: () => -1,
                  );
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {},
                    child: YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: false,
                        topActions: const <Widget>[
                          SizedBox(width: 8.0),
                        ],
                        // bottomActions: const [
                        //   SizedBox(),
                        // ],
                        thumbnail: const SizedBox(),
                        onReady: () {
                          setState(() {
                            _readyToPlay = true;
                          });
                          // _controller.setPlaybackRate(0.75);
                        },
                        onEnded: (data) {},
                      ),
                      builder: (context, player) => MainScaffold(
                        appBar: AppBar(
                          scrolledUnderElevation: 0.0,
                          backgroundColor: const Color(0xFF0F2027),
                          title: Text(
                            widget.listening.title,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        body: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              player,
                              CustomControl(
                                audioPlayer: _audioPlayer,
                                controller: _controller,
                                startPosition: widget.listening.start,
                                endPosition: widget.listening.end,
                                startDuration: _startDuration,
                                endDuration: _endDuration,
                                readyToPlay: _readyToPlay,
                                onVocabulary: () {},
                                onSeek: () {},
                              ),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: 50,
                              //   child: Center(
                              //       child: Row(
                              //     children: [
                              //       const SizedBox(
                              //         width: 12,
                              //       ),
                              //       Container(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 4, horizontal: 4),
                              //         decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(4),
                              //           border: Border.all(
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               'Normal',
                              //               style: PmpTextStyles.labelSemi
                              //                   .copyWith(
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //             const SizedBox(width: 12),
                              //             const Icon(
                              //               Icons.keyboard_arrow_down,
                              //               color: Colors.white,
                              //               size: 18,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       const Spacer(),
                              //       Container(
                              //         width: 40,
                              //         height: 40,
                              //         decoration: BoxDecoration(
                              //           color: Colors.blue,
                              //           border: Border.all(
                              //             width: 1,
                              //             color: Colors.white,
                              //           ),
                              //           borderRadius:
                              //               BorderRadius.circular(8),
                              //         ),
                              //         child: const Icon(Icons.view_agenda,
                              //             color: Colors.white),
                              //       ),
                              //       const SizedBox(width: 4),
                              //       Container(
                              //         width: 40,
                              //         height: 40,
                              //         decoration: BoxDecoration(
                              //           color: Colors.grey,
                              //           border: Border.all(
                              //             width: 1,
                              //             color: Colors.grey,
                              //           ),
                              //           borderRadius:
                              //               BorderRadius.circular(8),
                              //         ),
                              //         child: const Icon(Icons.view_array,
                              //             color: Colors.white),
                              //       ),
                              //       const SizedBox(width: 12),
                              //     ],
                              //   ),),
                              // ),
                              Expanded(
                                child: state.maybeWhen(
                                  loading: (message) {
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                  onParseCompleted: (subtitles) {
                                    return SubtitleDetailWidget(
                                      youtubeReadyToPlay: _readyToPlay,
                                      youtubeController: _controller,
                                      audioPlayerStateTrackerBloc:
                                          _audioPlayerStateTrackerBloc,
                                      audioPostionTrackerBloc:
                                          _audioPositionTrackerBloc,
                                      audioDurationTrackerBloc:
                                          _audioDurationTrackerBloc,
                                      subtitleBloc: _subtitleBloc,
                                      audioPlayer: _audioPlayer,
                                      hasVocabularies:
                                          widget.listening.hasVocabularies,
                                      subtitles: subtitles,
                                      hasMMSub: widget.listening.hasMMSubtitle,
                                      onUserChangePage: (subtitle) async {
                                        _controller.seekTo(subtitle.start);
                                      },
                                    );
                                  },
                                  orElse: () => Container(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
