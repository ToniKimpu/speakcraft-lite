import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/listening/shadowing_line_bloc.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/highlight_types/highlight_background.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/highlight_types/highlight_none.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/shadowing_player.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sheets/highlight_type_chooser.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../config/pmp_text_styles.dart';
import 'model/highlight_types.dart';
import 'model/subtitle_line.dart';
import 'shadowing_widgets/highlight_types/highlight_sentence.dart';

class ShadowingPage extends StatefulWidget {
  const ShadowingPage({
    super.key,
    required this.listening,
  });
  final Listening listening;

  @override
  State<ShadowingPage> createState() => _ShadowingPageState();
}

class _ShadowingPageState extends State<ShadowingPage>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;

  final _subtitleLineBloc = ShadowingLineBloc();

  // Use ValueNotifier instead of setState for position
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);

  // Extrapolate smooth position between YouTube controller updates (~250ms)
  // so the karaoke highlight fills at 60fps instead of stepping.
  late final Ticker _extrapolationTicker;
  Duration _baselinePosition = Duration.zero;
  final Stopwatch _sinceBaseline = Stopwatch();

  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSubscription;

  List<SubtitleLine> _subtitles = [];

  HighlightType _selectedHighlightType = HighlightType.readAlong;

  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  int? _lastScrolledIndex;
  bool _isUserScrolling = false;
  Timer? _scrollTimer;
  Timer? _scrollCheckTimer;

  bool _backPressed = false;

  @override
  void initState() {
    super.initState();
    _extrapolationTicker = createTicker(_onExtrapolationTick)..start();
    AppLogger.instance.debug(
        "_subtitleLineBlocLogs: ${widget.listening.shadowingPath} shadowing path");
    _subtitleLineBloc
        .add(ShadowingLineEvent.parse(widget.listening.shadowingPath));
    _controller = YoutubePlayerController(
      initialVideoId: widget.listening.youtubeId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
        startAt: widget.listening.start,
        endAt: widget.listening.end,
      ),
    )..addListener(_onPlayerPositionChanged);
  }

  void _onExtrapolationTick(Duration _) {
    if (!_sinceBaseline.isRunning) return;
    _positionNotifier.value = _baselinePosition + _sinceBaseline.elapsed;
  }

  void _onPlayerPositionChanged() {
    if (!mounted) return;

    // Real YouTube position update — snap baseline and restart (or stop) the
    // wall-clock stopwatch that drives _onExtrapolationTick between ticks.
    _baselinePosition = _controller.value.position;
    _sinceBaseline
      ..reset()
      ..start();
    if (!_controller.value.isPlaying) {
      _sinceBaseline.stop();
    }
    _positionNotifier.value = _baselinePosition;

    // Debounce scroll checks to avoid excessive computation
    _scrollCheckTimer?.cancel();
    _scrollCheckTimer = Timer(const Duration(milliseconds: 100), () {
      if (!mounted || _isUserScrolling) return;

      final currentIndex = _findCurrentSubtitleIndex();

      if (currentIndex == -1 || currentIndex == _lastScrolledIndex) {
        return;
      }

      final visibleIndexes = _itemPositionsListener.itemPositions.value
          .map((position) => position.index)
          .toList()
        ..sort();
      final firstTwoVisibleIndexes = visibleIndexes.take(2).toList();

      if (!firstTwoVisibleIndexes.contains(currentIndex)) {
        _lastScrolledIndex = currentIndex;
        _scrollToIndex(currentIndex);
      }
    });
  }

  // Binary search for better performance with large subtitle lists
  int _findCurrentSubtitleIndex() {
    if (_subtitles.isEmpty) return -1;

    final currentMs = _positionNotifier.value.inMilliseconds;

    // For small lists (< 50), linear search is fine and simpler
    if (_subtitles.length < 50) {
      for (int i = 0; i < _subtitles.length; i++) {
        final startMs = (_subtitles[i].start * 1000).toInt();
        final endMs = (_subtitles[i].end * 1000).toInt();
        if (currentMs >= startMs && currentMs <= endMs) {
          return i;
        }
      }
      return -1;
    }

    // Binary search for larger lists
    int left = 0;
    int right = _subtitles.length - 1;

    while (left <= right) {
      int mid = (left + right) ~/ 2;
      final startMs = (_subtitles[mid].start * 1000).toInt();
      final endMs = (_subtitles[mid].end * 1000).toInt();

      if (currentMs >= startMs && currentMs <= endMs) {
        return mid;
      } else if (currentMs < startMs) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }
    return -1;
  }

  void _scrollToIndex(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 700),
      alignment: 0.3,
    );
  }

  String getHighlightTypeLabel(HighlightType type) {
    switch (type) {
      case HighlightType.readAlong:
        return "Read Along";
      case HighlightType.line:
        return "Line";
      case HighlightType.none:
        return "None";
    }
  }

  @override
  void dispose() {
    _subtitleLineBloc.close();
    _extrapolationTicker.dispose();
    _sinceBaseline.stop();
    _scrollTimer?.cancel();
    _scrollCheckTimer?.cancel();
    _positionSub?.cancel();
    _playerStateSubscription?.cancel();
    _controller.dispose();
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
        setState(() {
          _backPressed = true;
        });
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: false,
          onReady: () {
            // _isPlayerReady = true;
          },
        ),
        builder: (context, player) {
          return _backPressed
              ? const Scaffold(
                  body: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : BlocConsumer<ShadowingLineBloc, ShadowingLineState>(
                  bloc: _subtitleLineBloc,
                  listener: (context, state) {
                    state.maybeWhen(
                      loaded: (subtitleLines) {
                        if (_subtitles.isEmpty) {
                          setState(() {
                            _subtitles = subtitleLines;
                          });
                        }
                      },
                      orElse: () => -1,
                    );
                  },
                  builder: (context, state) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text(
                          "Shadowing",
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return HighlightTypeChooser(
                                    onHighlightTypeSelected: (type) {
                                      setState(() {
                                        _selectedHighlightType = type;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.6)),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    getHighlightTypeLabel(
                                        _selectedHighlightType),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                      fontFamily: 'MM Lyrics Bold',
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.expand_more,
                                    color: Colors.white.withValues(alpha: 0.6),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
                      body: Column(
                        children: [
                          const SizedBox(height: 12),
                          ShadowingPlayer(
                            listening: widget.listening,
                            controller: _controller,
                            player: player,
                            positionListenable: _positionNotifier,
                            totalDuration:
                                Duration(seconds: widget.listening.end),
                            onTogglePlay: () {
                              final loading = _controller.value.playerState ==
                                      PlayerState.buffering ||
                                  !_controller.value.isReady;
                              if (loading) {
                                return;
                              }
                              if (_controller.value.playerState ==
                                  PlayerState.ended) {
                                _controller.seekTo(Duration.zero);
                                _controller.play();
                              } else if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            },
                          ),
                          Expanded(
                            child: state.maybeWhen(
                              loading: () {
                                return const Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              loaded: (subtitleLines) {
                                return NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification
                                        is UserScrollNotification) {
                                      if (scrollNotification.direction !=
                                          ScrollDirection.idle) {
                                        _isUserScrolling = true;
                                        _scrollTimer?.cancel();
                                        _scrollTimer = Timer(
                                            const Duration(milliseconds: 1500),
                                            () {
                                          _isUserScrolling = false;
                                        });
                                      }
                                      AppLogger.instance.debug(
                                          "_isUserScrollingLogic: $_isUserScrolling isUserScrolling");
                                    }
                                    return false;
                                  },
                                  child: ScrollablePositionedList.separated(
                                    itemScrollController:
                                        _itemScrollController,
                                    itemPositionsListener:
                                        _itemPositionsListener,
                                    itemCount: subtitleLines.length,
                                    padding: const EdgeInsets.only(top: 12),
                                    itemBuilder: (context, index) {
                                      final line = subtitleLines[index];
                                      final startTime = Duration(
                                          milliseconds:
                                              (line.start * 1000).toInt());
                                      final endTime = Duration(
                                          milliseconds:
                                              (line.end * 1000).toInt());
                                      String formatDuration(Duration d) {
                                        return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    formatDuration(startTime),
                                                    style: PmpTextStyles.sub
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                                Text(" --> ",
                                                    style: PmpTextStyles.sub),
                                                Text(
                                                    formatDuration(endTime),
                                                    style: PmpTextStyles.sub
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                              ],
                                            ),
                                            // HighlightNone doesn't read position, so
                                            // skip the ValueListenableBuilder wrap for
                                            // that branch and avoid per-frame rebuilds.
                                            if (_selectedHighlightType ==
                                                HighlightType.none)
                                              _buildHighlightWidget(
                                                line,
                                                Duration.zero,
                                              )
                                            else
                                              ValueListenableBuilder<Duration>(
                                                valueListenable:
                                                    _positionNotifier,
                                                builder:
                                                    (_, position, __) =>
                                                        _buildHighlightWidget(
                                                  line,
                                                  position,
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 12),
                                  ),
                                );
                              },
                              orElse: () => Container(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _buildHighlightWidget(
    SubtitleLine subtitleLine,
    Duration position,
  ) {
    switch (_selectedHighlightType) {
      case HighlightType.readAlong:
        return HighlightBackground(
          subtitleLine: subtitleLine,
          position: position,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HighlightType.line:
        return HighlightSentence(
          subtitleLine: subtitleLine,
          position: position,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HighlightType.none:
        return HighlightNone(
          subtitleLine: subtitleLine,
        );
    }
  }
}
