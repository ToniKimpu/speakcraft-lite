import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:speakcraft/shared_widgets/error_retry_view.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/model/subtitle/subtitle.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_word.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/custom_control.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/subtitle_pager.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/watch_settings_sheet.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/listening/shadowing_line_bloc.dart';
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

class _YoutubeVideoPageState extends State<YoutubeVideoPage>
    with SingleTickerProviderStateMixin {
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

  // ── Karaoke: smooth (60fps) playback position via ticker extrapolation ──
  // The controller only reports position at ~4Hz; the ticker fills the gaps.
  final _positionNotifier = ValueNotifier<Duration>(Duration.zero);
  late final Ticker _extrapolationTicker;
  Duration _baselinePosition = Duration.zero;
  final _sinceBaseline = Stopwatch();

  // Shadowing words supply the per-word timings for the karaoke highlight.
  final _shadowingBloc = ShadowingLineBloc();
  StreamSubscription<ShadowingLineState>? _shadowingSub;
  List<SubtitleLine> _shadowingLines = const [];
  // Words aligned to _subtitles by index (matched by time).
  List<List<SubtitleWord>> _wordsPerSubtitle = const [];

  // Persisted Watch settings.
  bool _showMM = true;
  bool _karaoke = false;
  double _speed = 1.0;

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

    _extrapolationTicker = createTicker(_onExtrapolationTick);

    _subtitleParsingBloc.add(SubtitleParsingEvent.parse(widget.listening));

    // Load shadowing words (for karaoke) if this video has them.
    if (widget.listening.shadowingPath.trim().isNotEmpty) {
      _shadowingSub = _shadowingBloc.stream.listen((state) {
        state.maybeWhen(
          loaded: (lines) {
            _shadowingLines = lines;
            _rebuildWordMap();
            if (mounted) setState(() {});
          },
          orElse: () {},
        );
      });
      _shadowingBloc.add(
        ShadowingLineEvent.parse(widget.listening.shadowingPath),
      );
    }

    _loadSettings();

    context.read<VideoStepProgressBloc>().add(
          VideoStepProgressEvent.markInProgress(
            widget.listening.youtubeId,
            VideoLessonStep.watch,
          ),
        );
  }

  // ── Karaoke position pipeline ──────────────────────────────────────────
  void _onExtrapolationTick(Duration _) {
    if (!_sinceBaseline.isRunning) return;
    _positionNotifier.value = _baselinePosition + _sinceBaseline.elapsed;
  }

  void _syncTicker() {
    final wantsKaraoke = _karaoke && _wordsPerSubtitle.any((w) => w.isNotEmpty);
    if (wantsKaraoke && !_extrapolationTicker.isActive) {
      _extrapolationTicker.start();
    } else if (!wantsKaraoke && _extrapolationTicker.isActive) {
      _extrapolationTicker.stop();
    }
  }

  /// Align shadowing words to each subtitle by time (the two files don't share
  /// object counts, but they share one absolute timeline).
  void _rebuildWordMap() {
    if (_subtitles.isEmpty || _shadowingLines.isEmpty) {
      _wordsPerSubtitle = const [];
      return;
    }
    final allWords = <SubtitleWord>[
      for (final l in _shadowingLines) ...l.words,
    ]..sort((a, b) => a.start.compareTo(b.start));
    _wordsPerSubtitle = [
      for (final s in _subtitles)
        () {
          final sStart = s.start.inMilliseconds / 1000.0;
          final sEnd = s.end.inMilliseconds / 1000.0;
          return allWords
              .where((w) => w.start >= sStart && w.start < sEnd)
              .toList();
        }(),
    ];
    _syncTicker();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _showMM = prefs.getBool('watch_show_mm') ?? widget.listening.hasMMSubtitle;
      _karaoke = prefs.getBool('watch_karaoke') ?? false;
      _speed = prefs.getDouble('watch_speed') ?? 1.0;
    });
    if (_readyToPlay) _controller.setPlaybackRate(_speed);
    _syncTicker();
  }

  Future<void> _persistSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('watch_show_mm', _showMM);
    await prefs.setBool('watch_karaoke', _karaoke);
    await prefs.setDouble('watch_speed', _speed);
  }

  void _openSettings() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => WatchSettingsSheet(
        showMM: _showMM,
        mmAvailable: widget.listening.hasMMSubtitle,
        karaoke: _karaoke,
        karaokeAvailable: _wordsPerSubtitle.any((w) => w.isNotEmpty),
        speed: _speed,
        onShowMM: (v) => setState(() {
          _showMM = v;
          _persistSettings();
        }),
        onKaraoke: (v) {
          setState(() => _karaoke = v);
          _syncTicker();
          _persistSettings();
        },
        onSpeed: (v) {
          setState(() => _speed = v);
          _controller.setPlaybackRate(v);
          _persistSettings();
        },
      ),
    );
  }

  void _onPlayerTick() {
    if (!mounted) return;

    // Re-snap the karaoke baseline to the real position on every controller
    // tick; the ticker extrapolates between these (~4Hz) updates. Freeze the
    // stopwatch while paused so the highlight holds; the next real tick re-snaps
    // after a seek (no drift).
    _baselinePosition = _controller.value.position;
    _sinceBaseline
      ..reset()
      ..start();
    if (!_controller.value.isPlaying) _sinceBaseline.stop();
    _positionNotifier.value = _baselinePosition;

    if (!_readyToPlay || _controller.value.isFullScreen) return;

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
    _extrapolationTicker.dispose();
    _sinceBaseline.stop();
    _shadowingSub?.cancel();
    _shadowingBloc.close();
    _audioPlayer.dispose();
    _controller.dispose();
    _subtitleIndexBloc.close();
    _subtitleParsingBloc.close();
    _positionNotifier.dispose();
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
                    if (_subtitles.isEmpty) {
                      _subtitles.addAll(subtitles);
                      _rebuildWordMap();
                      if (mounted) setState(() {});
                    }
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
                    onReady: () {
                      setState(() => _readyToPlay = true);
                      _controller.setPlaybackRate(_speed);
                    },
                    onEnded: (_) {},
                  ),
                  builder: (context, player) => Scaffold(
                    appBar: AppBar(
                      leading: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: GlassBackButton()),
                      scrolledUnderElevation: 0.0,
                      title: Text(
                        widget.listening.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      actions: [
                        IconButton(
                          tooltip: 'Subtitle settings',
                          icon: const Icon(Icons.tune),
                          onPressed: _openSettings,
                        ),
                      ],
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
                                hasMMSub: _showMM,
                                karaokeEnabled: _karaoke,
                                positionListenable: _positionNotifier,
                                wordsPerSubtitle: _wordsPerSubtitle,
                                importId: widget.listening.importId,
                                explanationLocked: !isUnlocked(
                                    isFree: widget.listening.isFree),
                                onUserChangePage: (subtitle) {
                                  _controller.seekTo(subtitle.start);
                                },
                              ),
                              error: (msg) => ErrorRetryView(
                                compact: true,
                                error: msg,
                                onRetry: () => _subtitleParsingBloc.add(
                                  SubtitleParsingEvent.parse(widget.listening),
                                ),
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
