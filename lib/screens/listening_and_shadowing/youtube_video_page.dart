import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/lyrics_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Homepage
class YoutubeVideoPage extends StatefulWidget {
  const YoutubeVideoPage({super.key});

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

  final _startPosition = 60;
  final _endPosition = 180;
  late final Duration _startDuration;
  late final Duration _endDuration;
  int sliderPosition = 0;
  late final _lyricsController = ScrollController();

  final int _currentIndex = 0;
  bool _readyToPlay = false;
  final List<double> _subtitleBoxHeights = [];
  final List<Subtitle> _subtitles = [];
  Subtitle _lastScrolledSubtitle = Subtitle.empty;
  Subtitle _selectedSubtitle = Subtitle.empty;
  bool _isUserScrolling = false;
  bool _showLoadingLayout = false;

  @override
  void initState() {
    super.initState();
    _startDuration = Duration(seconds: _startPosition);
    _endDuration = Duration(seconds: (_endPosition - _startPosition));
    _controller = YoutubePlayerController(
      initialVideoId: 'pZ1NdE69VTs',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        startAt: _startPosition,
        endAt: _endPosition,
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
        }
      },
    );
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
      return;
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
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
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
          _showLoadingLayout = true;
        });
      },
      child: _showLoadingLayout
          ? const Scaffold(
              body: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : YoutubePlayerBuilder(
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
              builder: (context, player) => Scaffold(
                appBar: AppBar(
                  title: Text(_videoMetaData.title),
                ),
                body: Column(
                  children: [
                    player,
                    CustomControl(
                      controller: _controller,
                      startPosition: _startPosition,
                      endPosition: _endPosition,
                      startDuration: _startDuration,
                      endDuration: _endDuration,
                      readyToPlay: _readyToPlay,
                    ),
                    Expanded(
                      child: LyricsWidget(
                        selectedSubtitle: _selectedSubtitle,
                        startPosition: _startPosition,
                        endPosition: _endPosition,
                        mainController: _lyricsController,
                        onTap: (subtitle) {
                          setState(() {
                            _controller.seekTo(subtitle.start);
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              _isUserScrolling = false;
                              _selectedSubtitle = subtitle;
                            });
                          });
                        },
                        getSubtitleBoxHeights: (subtitleBoxHeights, subtitles) {
                          if (_subtitleBoxHeights.isEmpty) {
                            _subtitleBoxHeights.addAll(subtitleBoxHeights);
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
                  ],
                ),
              ),
            ),
    );
  }
}
