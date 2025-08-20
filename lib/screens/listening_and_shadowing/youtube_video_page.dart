import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/lyrics_widget.dart';
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
    required this.enableMMSub,
  });
  final Listening listening;
  final bool enableMMSub;

  @override
  State<YoutubeVideoPage> createState() => _YoutubeVideoPageState();
}

class _YoutubeVideoPageState extends State<YoutubeVideoPage> {
  late YoutubePlayerController _controller;

  bool _isPlayerReady = false;

  late final Duration _startDuration;
  late final Duration _endDuration;
  int sliderPosition = 0;
  final ScrollController _lyricsController = ScrollController();

  bool _readyToPlay = false;
  final List<Subtitle> _subtitles = [];
  Subtitle _lastScrolledSubtitle = Subtitle.empty();
  Subtitle _selectedSubtitle = Subtitle.empty();
  bool _isUserScrolling = false;
  bool _showLoadingLayout = false;
  Timer? _scrollTimer;
  final _showVocabularyNotifier = ValueNotifier<bool>(false);

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
    _lyricsController.addListener(
      () {
        if (_lyricsController.position.userScrollDirection !=
            ScrollDirection.idle) {
          _isUserScrolling = true;
          _scrollTimer?.cancel();
          _scrollTimer = Timer(const Duration(milliseconds: 1500), () {
            // User has stopped scrolling
            setState(() {
              _isUserScrolling = false;
            });
          });
        }
      },
    );
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      // debugPrint("_playerStateSubscription: ${playerState.playing} playing");
      _audioPlayerStateTrackerBloc.add(
        AudioPlayerEvent.updatePlayerState(playerState),
      );
    });
    _positionSub = _audioPlayer.positionStream.listen(
      (pos) {
        _audioPositionTrackerBloc
            .add(AudioPlayerEvent.setCurrentPosition(pos.inSeconds));
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
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _scrollToNext();
        _updateCurrentSubtitleIndex();
      });
    }
  }

  //For Lyrics widget
  void _scrollToNext() {
    if (!_lyricsController.hasClients || _isUserScrolling) {
      return; // Ensure scrolling is possible
    }

    final position = _controller.value.position.inSeconds;

    final subtitle = _subtitles.firstWhere(
      (subtitle) =>
          position >= subtitle.start.inSeconds &&
          position < subtitle.end.inSeconds,
      orElse: () => Subtitle.empty(),
    );

    if (subtitle.isEmpty || subtitle.id == _lastScrolledSubtitle.id) {
      return;
    }
    _lastScrolledSubtitle = subtitle;

    final currentScroll = _lyricsController.position.pixels;
    final maxScroll = _lyricsController.position.maxScrollExtent;
    if (currentScroll >= maxScroll) {
      _selectedSubtitle = _lastScrolledSubtitle;
      if (_lastScrolledSubtitle.scrollPosition >= maxScroll) {
        return;
      }
    }
    _lyricsController.animateTo(
      _lastScrolledSubtitle.scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _selectedSubtitle = _lastScrolledSubtitle;
    });
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
    _showVocabularyNotifier.dispose();
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
          if (_showVocabularyNotifier.value) {
            _showVocabularyNotifier.value = false;
            return;
          }
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
            : GestureDetector(
                onTap: () {
                  if (_showVocabularyNotifier.value) {
                    _showVocabularyNotifier.value = false;
                  }
                },
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
                      _isPlayerReady = true;
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
                            onVocabulary: () {
                              _showVocabularyNotifier.value =
                                  !_showVocabularyNotifier.value;
                            },
                            onSeek: () {
                              setState(() {
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  _isUserScrolling = false;
                                });
                              });
                            },
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ValueListenableBuilder<bool>(
                                      valueListenable: _showVocabularyNotifier,
                                      builder:
                                          (context, showVocabulary, childF) {
                                        return Offstage(
                                          offstage: showVocabulary,
                                          child: LyricsWidget(
                                            subtitleParsingBloc:
                                                _subtitleParsingBloc,
                                            selectedSubtitle: _selectedSubtitle,
                                            listening: widget.listening,
                                            mainController: _lyricsController,
                                            enableMMSub: widget.enableMMSub,
                                            onTap: (subtitle) {
                                              setState(() {
                                                _controller
                                                    .seekTo(subtitle.start);
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100), () {
                                                  _isUserScrolling = false;
                                                  _selectedSubtitle = subtitle;
                                                });
                                              });
                                            },
                                            getSubtitleBoxHeights:
                                                (subtitles) async {
                                              if (_subtitles.isEmpty) {
                                                _subtitles.addAll(subtitles);
                                                if (_subtitles.isNotEmpty) {
                                                  final subtitle =
                                                      _subtitles.first;
                                                  debugPrint(
                                                      "_durationSub: //${subtitle.audioName} audioName");
                                                  if (subtitle
                                                      .audioName.isNotEmpty) {
                                                    _audioPlayer.setUrl(
                                                      subtitle.audioName,
                                                    );
                                                  }
                                                }
                                                setState(() {
                                                  _readyToPlay = true;
                                                });
                                              }
                                            },
                                          ),
                                        );
                                      }),
                                ),
                                if (_subtitles.isNotEmpty)
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    right: 6,
                                    bottom: 6,
                                    child: SubtitleDetailWidget(
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
                                      showSubtitleDetail:
                                          _showVocabularyNotifier,
                                      subtitles: _subtitles,
                                      hasMMSub: widget.listening.hasMMSubtitle,
                                      onUserChangePage: (subtitle) async {
                                        final isPaused =
                                            !_controller.value.isPlaying;
                                        _controller.seekTo(subtitle.start);
                                        if (isPaused) {
                                          // Re-pause after a brief delay to avoid auto-play
                                          await Future.delayed(const Duration(
                                              milliseconds: 100));
                                          _controller.pause();
                                        }
                                      },
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
