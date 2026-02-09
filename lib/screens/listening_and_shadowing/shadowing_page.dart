import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/hightlight_types/hightlight_background.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/hightlight_types/hightlight_none.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/hightlight_types/hightlight_textcolor.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/hightlight_types/hightlight_underline.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_widgets/shadowing_player.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sheets/hightlight_type_chooser.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../config/pmp_text_styles.dart';
import 'model/hightlight_types.dart';
import 'model/subtitle_line.dart';
import 'shadowing_widgets/hightlight_types/hightlight_sentence.dart';

class ShadowingPage extends StatefulWidget {
  const ShadowingPage({
    super.key,
    required this.listening,
  });
  final Listening listening;

  @override
  State<ShadowingPage> createState() => _ShadowingPageState();
}

class _ShadowingPageState extends State<ShadowingPage> {
  late YoutubePlayerController _controller;

  final _subtitleLineBloc = SubtitleBloc();

  // Use ValueNotifier instead of setState for position
  final ValueNotifier<Duration> _positionNotifier =
      ValueNotifier(Duration.zero);

  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSubscription;

  List<SubtitleLine> _subtitles = [];

  HightlightTypes _selectedHighlightType = HightlightTypes.sentence;

  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  int? _lastScrolledIndex;
  bool _isUserScrolling = false;
  bool _appScrolling = false;
  Timer? _scrollTimer;
  Timer? _scrollCheckTimer;

  bool _backPressed = false;

  @override
  void initState() {
    super.initState();
    debugPrint(
        "_subtitleLineBlocLogs: ${widget.listening.shadowingPath} shadowing path");
    _subtitleLineBloc
        .add(SubtitleEvent.parseSubtitleLine(widget.listening.shadowingPath));
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

  void _onPlayerPositionChanged() {
    if (!mounted) return;

    // Update position without setState
    _positionNotifier.value = _controller.value.position;

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
        setState(() {
          _lastScrolledIndex = currentIndex;
        });
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
    _appScrolling = true;
    _itemScrollController
        .scrollTo(
      index: index,
      duration: const Duration(milliseconds: 700),
      alignment: 0.3,
    )
        .then((_) {
      _appScrolling = false;
    });
  }

  String getHighlightTypeLabel(HightlightTypes type) {
    switch (type) {
      case HightlightTypes.background:
        return "Background";
      case HightlightTypes.underline:
        return "Underline";
      case HightlightTypes.textColor:
        return "Text Color";
      case HightlightTypes.sentence:
        return "Sentence";
      case HightlightTypes.none:
        return "None";
    }
  }

  @override
  void dispose() {
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
                  bloc: _subtitleLineBloc,
                  listener: (context, state) {
                    state.maybeWhen(
                      onParseSubtitleLineCompleted: (subtitleLines) {
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
                    return MainScaffold(
                      appBar: AppBar(
                        backgroundColor: const Color(0xFF0F2027),
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
                                  return HightlightTypeChooser(
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
                          // Use ValueListenableBuilder for position-dependent widget
                          ValueListenableBuilder<Duration>(
                            valueListenable: _positionNotifier,
                            builder: (context, position, child) {
                              return ShadowingPlayer(
                                listening: widget.listening,
                                controller: _controller,
                                player: player,
                                position: position,
                                totalDuration:
                                    Duration(seconds: widget.listening.end),
                                onTogglePlay: () {
                                  final loading =
                                      _controller.value.playerState ==
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
                              );
                            },
                          ),
                          Expanded(
                            child: state.maybeWhen(
                              loading: (message) {
                                return const Center(
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              onParseSubtitleLineCompleted: (subtitleLines) {
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
                                          setState(() {
                                            _isUserScrolling = false;
                                          });
                                        });
                                      }
                                      debugPrint(
                                          "_isUserScrollingLogic: $_isUserScrolling isUserScrolling");
                                    }
                                    return false;
                                  },
                                  child: ValueListenableBuilder<Duration>(
                                    valueListenable: _positionNotifier,
                                    builder: (context, position, child) {
                                      return ScrollablePositionedList.separated(
                                        itemScrollController:
                                            _itemScrollController,
                                        itemPositionsListener:
                                            _itemPositionsListener,
                                        itemCount: subtitleLines.length,
                                        padding: const EdgeInsets.only(top: 12),
                                        itemBuilder: (context, index) {
                                          final line = subtitleLines[index];
                                          final nextLine =
                                              (index < subtitleLines.length - 1)
                                                  ? subtitleLines[index + 1]
                                                  : null;
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
                                                        formatDuration(
                                                            startTime),
                                                        style: PmpTextStyles.sub
                                                            .copyWith(
                                                                color: Colors
                                                                    .white)),
                                                    Text(" --> ",
                                                        style:
                                                            PmpTextStyles.sub),
                                                    Text(
                                                        formatDuration(endTime),
                                                        style: PmpTextStyles.sub
                                                            .copyWith(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                                _buildHighlightWidget(
                                                  line,
                                                  nextLine,
                                                  position,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(height: 12),
                                      );
                                    },
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
    SubtitleLine? nextSubtitleLine,
    Duration position,
  ) {
    switch (_selectedHighlightType) {
      case HightlightTypes.background:
        return HightlightBackground(
          subtitleLine: subtitleLine,
          nextSubtitleLine: nextSubtitleLine,
          position: position,
          appScrolling: _appScrolling,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HightlightTypes.textColor:
        return HightlightTextcolor(
          subtitleLine: subtitleLine,
          nextSubtitleLine: nextSubtitleLine,
          position: position,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HightlightTypes.underline:
        return HightlightUnderline(
          subtitleLine: subtitleLine,
          nextSubtitleLine: nextSubtitleLine,
          position: position,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HightlightTypes.sentence:
        return HighlightSentence(
          subtitleLine: subtitleLine,
          nextSubtitleLine: nextSubtitleLine,
          position: position,
          onSeek: (seekPosition) {
            _controller.seekTo(seekPosition);
          },
        );
      case HightlightTypes.none:
        return HightlightNone(
          subtitleLine: subtitleLine,
        );
    }
  }
}
