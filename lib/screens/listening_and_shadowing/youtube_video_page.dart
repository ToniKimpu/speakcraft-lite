import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/model/subtitle/subtitle.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/subtitle_pager.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/listening/subtitle_index_bloc.dart';
import '../../bloc/listening/subtitle_parsing_bloc.dart';

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
  late final YoutubePlayerController _controller;
  late final Duration _startDuration;
  late final Duration _endDuration;

  bool _readyToPlay = false;
  bool _showLoadingLayout = false;
  bool _markedWatchDone = false;
  final List<Subtitle> _subtitles = [];
  int _subtitlePageIndex = 0;

  final _subtitleIndexBloc = SubtitleIndexBloc();
  final _subtitleParsingBloc = SubtitleParsingBloc();
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startDuration = Duration(seconds: widget.listening.start);
    _endDuration = Duration(
      seconds: widget.listening.end - widget.listening.start,
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
    )..addListener(_onPlayerTick);

    _subtitleParsingBloc.add(SubtitleParsingEvent.parse(widget.listening));

    context.read<VideoStepProgressBloc>().add(
          VideoStepProgressEvent.markInProgress(
            widget.listening.youtubeId,
            VideoLessonStep.watch,
          ),
        );
  }

  void _onPlayerTick() {
    if (!_readyToPlay || !mounted || _controller.value.isFullScreen) return;

    if (!_markedWatchDone) {
      final segmentLen = widget.listening.end - widget.listening.start;
      final positionInSegment =
          _controller.value.position.inSeconds - widget.listening.start;
      if (segmentLen > 0 && positionInSegment >= segmentLen * 0.8) {
        _markedWatchDone = true;
        context.read<VideoStepProgressBloc>().add(
              VideoStepProgressEvent.markDone(
                widget.listening.youtubeId,
                VideoLessonStep.watch,
              ),
            );
      }
    }

    final newIndex = _findCurrentSubtitleIndex();
    if (newIndex == -1 || newIndex == _subtitlePageIndex) return;
    _subtitlePageIndex = newIndex;
    _subtitleIndexBloc.add(SubtitleIndexEvent.set(newIndex));
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
    _audioPlayer.dispose();
    _controller.dispose();
    _subtitleIndexBloc.close();
    _subtitleParsingBloc.close();
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
        setState(() => _showLoadingLayout = true);
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
          : BlocConsumer<SubtitleParsingBloc, SubtitleParsingState>(
              bloc: _subtitleParsingBloc,
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (subtitles) {
                    if (_subtitles.isEmpty) _subtitles.addAll(subtitles);
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: false,
                    topActions: const <Widget>[SizedBox(width: 8.0)],
                    thumbnail: const SizedBox(),
                    onReady: () => setState(() => _readyToPlay = true),
                    onEnded: (_) {},
                  ),
                  builder: (context, player) => Scaffold(
                    appBar: AppBar(
                      scrolledUnderElevation: 0.0,
                      title: Text(
                        widget.listening.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    body: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          player,
                          const SizedBox(height: 8),
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
                              loading: () => const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              loaded: (subtitles) => SubtitlePager(
                                youtubeController: _controller,
                                audioPlayer: _audioPlayer,
                                subtitleIndexBloc: _subtitleIndexBloc,
                                subtitles: subtitles,
                                hasMMSub: widget.listening.hasMMSubtitle,
                                explanationLocked: !isUnlocked(
                                    isFree: widget.listening.isFree),
                                onUserChangePage: (subtitle) {
                                  _controller.seekTo(subtitle.start);
                                },
                              ),
                              orElse: () => const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
