import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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

  Duration _position = Duration.zero;

  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSubscription;

  Future<List<SubtitleLine>> loadSubtitles() async {
    final jsonString =
        await rootBundle.loadString("assets/subtitles/audio.json");
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => SubtitleLine.fromJson(e)).toList();
  }

  List<SubtitleLine> _subtitles = [];

  HightlightTypes _selectedHighlightType = HightlightTypes.sentence;

  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  int? _lastScrolledIndex;
  bool _isUserScrolling = false;
  bool _appScrolling = false;
  Timer? _scrollTimer;

  bool _backPressed = false;

  @override
  void initState() {
    super.initState();
    loadSubtitles().then((data) {
      setState(() => _subtitles = data);
    });
    _controller = YoutubePlayerController(
      initialVideoId: "H14bBuluwB8",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
        startAt: 0,
        endAt: 374,
      ),
    )..addListener(
        () {
          if (mounted) {
            setState(() {
              _position = _controller.value.position;
              debugPrint(
                  "_currentPlayingPosition: ${_position.inSeconds} in Seconds!");
            });

            if (_isUserScrolling) {
              return;
            }
            final currentIndex = _subtitles.indexWhere((line) {
              final start = Duration(milliseconds: (line.start * 1000).toInt());
              final end = Duration(milliseconds: (line.end * 1000).toInt());
              return _position >= start && _position <= end;
            });

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
              _appScrolling = true;
              _itemScrollController
                  .scrollTo(
                    index: currentIndex,
                    duration: const Duration(milliseconds: 500),
                    alignment: 0.3,
                  )
                  .then(
                    (_) => _appScrolling = false,
                  );
            }
          }
        },
      );
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
    _positionSub?.cancel();
    _playerStateSubscription?.cancel();
    _controller.dispose();
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
              : MainScaffold(
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
                                getHighlightTypeLabel(_selectedHighlightType),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.8),
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
                      ShadowingPlayer(
                        listening: widget.listening,
                        controller: _controller,
                        player: player,
                        position: _position,
                        totalDuration: Duration(seconds: widget.listening.end),
                      ),
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is UserScrollNotification) {
                              // Called when user starts or stops scrolling
                              if (scrollNotification.direction !=
                                  ScrollDirection.idle) {
                                _isUserScrolling = true;
                                _scrollTimer?.cancel();
                                _scrollTimer = Timer(
                                    const Duration(milliseconds: 1500), () {
                                  // User has stopped scrolling
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
                          child: ScrollablePositionedList.separated(
                            itemScrollController: _itemScrollController,
                            itemPositionsListener: _itemPositionsListener,
                            itemCount: _subtitles.length,
                            padding: const EdgeInsets.only(top: 12),
                            itemBuilder: (context, index) {
                              debugPrint(
                                  "_scrollablePositionIndex: $index index");
                              final line = _subtitles[index];
                              final nextLine = (index < _subtitles.length - 1)
                                  ? _subtitles[index + 1]
                                  : null;
                              final startTime = Duration(
                                  milliseconds: (line.start * 1000).toInt());
                              final endTime = Duration(
                                  milliseconds: (line.end * 1000).toInt());
                              String formatDuration(Duration d) {
                                return "${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";
                              }

                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(formatDuration(startTime),
                                            style: PmpTextStyles.sub
                                                .copyWith(color: Colors.white)),
                                        Text(" --> ", style: PmpTextStyles.sub),
                                        Text(formatDuration(endTime),
                                            style: PmpTextStyles.sub
                                                .copyWith(color: Colors.white)),
                                      ],
                                    ),
                                    _buildHighlightWidget(
                                      line,
                                      nextLine,
                                      _position,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
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
      case HightlightTypes.sentence: // new
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
