import 'package:flutter/material.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_practice_widgets/sentence_practice_widget_two.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'sentence_practice_widgets/listening_footer_widget.dart';

class ListeningSentencePracticePage extends StatefulWidget {
  const ListeningSentencePracticePage({
    super.key,
    required this.complete,
    required this.listening,
    required this.listeningQuestions,
  });
  final bool complete;
  final Listening listening;
  final List<ListeningQuestion> listeningQuestions;

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
  final Duration _endDuration = Duration.zero;

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
    if (page >= 0 && page < widget.listeningQuestions.length) {
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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  ),
                  Positioned(
                    right: 10,
                    bottom: -20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.listeningQuestions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final subtitleLine = widget.listeningQuestions[index];
                    return const SentencePracticeWidgetTwo();
                    // return SentencePracticeWidget(
                    //   subtitleLine: subtitleLine,
                    //   controller: _controller,
                    //   complete: widget.complete,
                    //   onListenAudio: (start, end) {
                    //     _endDuration = end;
                    //     _controller.seekTo(start);
                    //     _controller.play();
                    //     debugPrint(
                    //         "_sentencePracticeWidgetLogs: start playing.....");
                    //   },
                    //   onDone: (correct) async {
                    //     setState(
                    //       () => _nextEnabled = true,
                    //     );
                    //     if (index == widget.subtitleLines.length - 1) {
                    //       final completedGroupCount =
                    //           await SharedPreferenceUtils.getInt(
                    //                   widget.listening.youtubeId) ??
                    //               0;
                    //       await SharedPreferenceUtils.saveInt(
                    //         widget.listening.youtubeId,
                    //         completedGroupCount + 1,
                    //       );
                    //     }
                    //   },
                    // );
                  },
                ),
              ),
              // Footer
              if (widget.listeningQuestions.isNotEmpty)
                ListeningFooterWidget(
                  listeningQuestions: widget.listeningQuestions,
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
