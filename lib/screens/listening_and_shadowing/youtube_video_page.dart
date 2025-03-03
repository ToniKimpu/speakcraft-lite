import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _startDuration = Duration(seconds: _startPosition);
    _endDuration = Duration(seconds: (_endPosition - _startPosition));
    _controller = YoutubePlayerController(
      initialVideoId: 'pZ1NdE69VTs',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
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
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
    return YoutubePlayerBuilder(
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
            ),
            const Expanded(child: LyricsWidget()),
          ],
        ),
      ),
    );
  }
}
