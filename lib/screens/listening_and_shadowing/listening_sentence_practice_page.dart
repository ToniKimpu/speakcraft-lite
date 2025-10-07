import 'package:flutter/material.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_practice_widgets/sentence_practice_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../services/share_preference_utils.dart';
import 'model/subtitle_line.dart';
import 'sentence_practice_widgets/listening_footer_widget.dart';

class ListeningSentencePracticePage extends StatefulWidget {
  const ListeningSentencePracticePage({
    super.key,
    required this.complete,
    required this.listening,
    required this.subtitleLines,
  });
  final bool complete;
  final Listening listening;
  final List<SubtitleLine> subtitleLines;

  @override
  State<ListeningSentencePracticePage> createState() =>
      _ListeningSentencePracticePageState();
}

class _ListeningSentencePracticePageState
    extends State<ListeningSentencePracticePage> {
  late final PageController _pageController;
  int _currentPage = 0;

  late YoutubePlayerController _controller;
  Duration _position = Duration.zero;
  Duration _endDuration = Duration.zero;

  bool _nextEnabled = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
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
              if (_position.inMilliseconds > _endDuration.inMilliseconds) {
                _controller.pause();
              }
            });
          }
        },
      );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page, bool previous) {
    if (page >= 0 && page < widget.subtitleLines.length) {
      _controller.pause();
      if (previous) {
        _nextEnabled = true;
      } else {
        _nextEnabled = false;
      }
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
        onReady: () {
          // _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return MainScaffold(
          appBar: AppBar(
            title: const Text("Listening Practice"),
          ),
          body: Column(
            children: [
              Offstage(
                offstage: true,
                child: player,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.subtitleLines.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final subtitleLine = widget.subtitleLines[index];
                    return SentencePracticeWidget(
                      subtitleLine: subtitleLine,
                      controller: _controller,
                      complete: widget.complete,
                      onListenAudio: (start, end) {
                        _endDuration = end;
                        _controller.seekTo(start);
                        _controller.play();
                        debugPrint(
                            "_sentencePracticeWidgetLogs: start playing.....");
                      },
                      onDone: (correct) async {
                        setState(
                          () => _nextEnabled = true,
                        );
                        if (index == widget.subtitleLines.length - 1) {
                          final completedGroupCount =
                              await SharedPreferenceUtils.getInt(
                                      widget.listening.youtubeId) ??
                                  0;
                          await SharedPreferenceUtils.saveInt(
                            widget.listening.youtubeId,
                            completedGroupCount + 1,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              // Footer
              if (widget.subtitleLines.isNotEmpty)
                ListeningFooterWidget(
                  subtitleLines: widget.subtitleLines,
                  currentPage: _currentPage,
                  onPageChanged: _goToPage,
                  nextEnabled: widget.complete || _nextEnabled,
                ),
            ],
          ),
        );
      },
    );
  }
}
