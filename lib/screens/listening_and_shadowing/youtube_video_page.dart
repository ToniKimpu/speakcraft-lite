import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/subtitle_detail_widget.dart';
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
        AppLogger.instance
            .debug("_durationSub: ${duration.inSeconds} inSeconds!");
      },
    );
    _subtitleParsingBloc.add(SubtitleEvent.parseSubtitle(widget.listening));
  }

  void listener() {
    if (!_readyToPlay || !mounted || _controller.value.isFullScreen) return;
    _updateCurrentSubtitleIndex();
  }

  void _updateCurrentSubtitleIndex() {
    final newIndex = _findCurrentSubtitleIndex();
    if (newIndex == -1 || newIndex == _subtitlePageIndex) return;
    _subtitlePageIndex = newIndex;
    AppLogger.instance
        .debug("_currentSubtitlePageIndex: $_subtitlePageIndex");
    _subtitleBloc.add(SubtitleEvent.setCurrentPageIndex(_subtitlePageIndex));
  }

  int _findCurrentSubtitleIndex() {
    if (_subtitles.isEmpty) return -1;
    final positionSeconds = _controller.value.position.inSeconds;

    if (_subtitles.length < 50) {
      for (int i = 0; i < _subtitles.length; i++) {
        final startS = _subtitles[i].start.inSeconds;
        final endS = _subtitles[i].end.inSeconds;
        if (positionSeconds >= startS && positionSeconds < endS) return i;
      }
      return -1;
    }

    int left = 0;
    int right = _subtitles.length - 1;
    while (left <= right) {
      final mid = (left + right) ~/ 2;
      final startS = _subtitles[mid].start.inSeconds;
      final endS = _subtitles[mid].end.inSeconds;
      if (positionSeconds >= startS && positionSeconds < endS) return mid;
      if (positionSeconds < startS) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }
    return -1;
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _positionSub?.cancel();
    _durationSub.cancel();
    _audioPlayer.dispose();
    _controller.dispose();
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
            ? const Scaffold(
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
                  return YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: false,
                      topActions: const <Widget>[
                        SizedBox(width: 8.0),
                      ],
                      thumbnail: const SizedBox(),
                      onReady: () {
                        setState(() {
                          _readyToPlay = true;
                        });
                      },
                      onEnded: (data) {},
                    ),
                    builder: (context, player) => Scaffold(
                        appBar: AppBar(
                          scrolledUnderElevation: 0.0,
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
                              ListenableBuilder(
                                listenable: _controller,
                                builder: (_, __) => CustomControl(
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
                              ),
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
                    );
                },
              ),
      ),
    );
  }
}
