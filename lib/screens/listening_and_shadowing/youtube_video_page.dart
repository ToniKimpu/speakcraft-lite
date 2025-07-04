import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pmp_english/bloc/listening/listening_bloc.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/listening_vocabulary_list.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/lyrics_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final double _volume = 100;
  final bool _muted = false;
  bool _isPlayerReady = false;

  late final Duration _startDuration;
  late final Duration _endDuration;
  int sliderPosition = 0;
  final ScrollController _lyricsController = ScrollController();

  final int _currentIndex = 0;
  bool _readyToPlay = false;
  final List<double> _subtitleBoxHeights = [];
  final List<Subtitle> _subtitles = [];
  Subtitle _lastScrolledSubtitle = Subtitle.empty;
  Subtitle _selectedSubtitle = Subtitle.empty;
  bool _isUserScrolling = false;
  bool _showLoadingLayout = false;
  Timer? _scrollTimer;
  final _showVocabularyNotifier = ValueNotifier<bool>(false);
  final _vocabularyBloc = ListeningBloc();

  @override
  void initState() {
    super.initState();
    _startDuration = Duration(seconds: widget.listening.start);
    _endDuration = Duration(
      seconds: (widget.listening.end - widget.listening.start),
    );
    _controller = YoutubePlayerController(
      initialVideoId: widget.listening.youtubeId,
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
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
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
    _vocabularyBloc
        .add(ListeningEvent.loadVocabulariesByListening(widget.listening.id));
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
        _scrollToNext();
      });
    }
  }

  void _scrollToNext() {
    if (!_lyricsController.hasClients || _isUserScrolling) {
      return; // Ensure scrolling is possible
    }

    final position = _controller.value.position.inSeconds;

    final subtitle = _subtitles.firstWhere(
      (subtitle) =>
          position >= subtitle.start.inSeconds &&
          position < subtitle.end.inSeconds,
      orElse: () => Subtitle.empty,
    );

    if (subtitle.isEmpty ||
        subtitle.widgetHeight == null ||
        subtitle.id == _lastScrolledSubtitle.id) {
      return;
    }
    _lastScrolledSubtitle = subtitle;

    final currentScroll = _lyricsController.position.pixels;
    final maxScroll = _lyricsController.position.maxScrollExtent;
    if (currentScroll >= maxScroll) {
      _selectedSubtitle = _lastScrolledSubtitle;
      if (_lastScrolledSubtitle.scrollPosition! >= maxScroll) {
        return;
      }
    }
    _lyricsController.animateTo(
      _lastScrolledSubtitle.scrollPosition!,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      _selectedSubtitle = _lastScrolledSubtitle;
    });
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _showVocabularyNotifier.dispose();
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    _lyricsController.removeListener(listener);
    _lyricsController.dispose();
    _vocabularyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                _isUserScrolling = false;
                              });
                            });
                          },
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: LyricsWidget(
                                  selectedSubtitle: _selectedSubtitle,
                                  listening: widget.listening,
                                  mainController: _lyricsController,
                                  enableMMSub: widget.enableMMSub,
                                  onTap: (subtitle) {
                                    setState(() {
                                      _controller.seekTo(subtitle.start);
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        _isUserScrolling = false;
                                        _selectedSubtitle = subtitle;
                                      });
                                    });
                                  },
                                  getSubtitleBoxHeights:
                                      (subtitleBoxHeights, subtitles) {
                                    if (_subtitleBoxHeights.isEmpty) {
                                      _subtitleBoxHeights
                                          .addAll(subtitleBoxHeights);
                                    }
                                    if (_subtitles.isEmpty) {
                                      _subtitles.addAll(subtitles);
                                    }
                                    setState(() {
                                      _readyToPlay = true;
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 12,
                                right: 12,
                                bottom: 12,
                                child: ListeningVocabularyList(
                                  showVocabularyNotifier:
                                      _showVocabularyNotifier,
                                  vocabularyBloc: _vocabularyBloc,
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
    );
  }
}
