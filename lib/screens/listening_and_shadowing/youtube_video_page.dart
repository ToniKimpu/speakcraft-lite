import 'package:flutter/material.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
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
    final currentPosition = _controller.value.position - _startDuration;
    final adjustedCurrentPosition = currentPosition.isNegative
        ? const Duration(seconds: 0)
        : currentPosition;
    final remainingDuration = _endDuration - adjustedCurrentPosition;
    sliderPosition =
        currentPosition.inSeconds.clamp(0, (_endPosition - _startPosition));
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
        body: ListView(
          children: [
            player,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: PmpColors.primary400,
                  child: Row(
                    children: [
                      Material(
                        color: PmpColors.white,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            final currentPosition =
                                _controller.value.position.inSeconds;
                            final newPosition = (currentPosition - 10)
                                .clamp(_startPosition, _endPosition);
                            _controller.seekTo(Duration(seconds: newPosition));
                          },
                          child: const SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              Icons.replay_10,
                              color: PmpColors.primary400,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        adjustedCurrentPosition.formatDuration(),
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackShape: CustomTrackShape(),
                          ),
                          child: Slider(
                            value: sliderPosition.toDouble(),
                            min: 0,
                            max: _endPosition.toDouble() -
                                _startPosition.toDouble(),
                            thumbColor: Colors.orange,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              debugPrint("_sliderValue: $value value");
                              int seekPosition = value.toInt() + _startPosition;
                              _controller
                                  .seekTo(Duration(seconds: seekPosition));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '- ${remainingDuration.formatDuration()}',
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Material(
                        color: PmpColors.white,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            final currentPosition =
                                _controller.value.position.inSeconds;
                            final newPosition = (currentPosition + 10)
                                .clamp(_startPosition, _endPosition);
                            _controller.seekTo(Duration(seconds: newPosition));
                          },
                          child: const SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              Icons.forward_10,
                              color: PmpColors.primary400,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Material(
                        color: PmpColors.white,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: PmpColors.primary400,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
