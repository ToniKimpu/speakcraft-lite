import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_practice_widgets/sentence_practice_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'model/subtitle_line.dart';
import 'sentence_practice_widgets/listening_footer_widget.dart';

class ListeningSentencePracticePage extends StatefulWidget {
  const ListeningSentencePracticePage({super.key});

  @override
  State<ListeningSentencePracticePage> createState() =>
      _ListeningSentencePracticePageState();
}

class _ListeningSentencePracticePageState
    extends State<ListeningSentencePracticePage> {
  late final PageController _pageController;
  int _currentPage = 0;

  Future<List<SubtitleLine>> loadSubtitles() async {
    final jsonString =
        await rootBundle.loadString("assets/subtitles/audio.json");
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => SubtitleLine.fromJson(e)).toList();
  }

  List<SubtitleLine> _subtitles = [];

  late YoutubePlayerController _controller;
  Duration _position = Duration.zero;
  Duration _endDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
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

  void _goToPage(int page) {
    if (page >= 0 && page < _subtitles.length) {
      _controller.pause();
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
                  itemCount: _subtitles.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final subtitleLine = _subtitles[index];
                    return SentencePracticeWidget(
                      subtitleLine: subtitleLine,
                      controller: _controller,
                      onListenAudio: (start, end) {
                        _endDuration = end;
                        _controller.seekTo(start);
                        _controller.play();

                        debugPrint(
                            "_sentencePracticeWidgetLogs: start playing.....");
                      },
                    );
                  },
                ),
              ),
              // Footer
              if (_subtitles.isNotEmpty)
                ListeningFooterWidget(
                  subtitleLines: _subtitles,
                  currentPage: _currentPage,
                  onPageChanged: _goToPage,
                  nextEnabled: true,
                ),
            ],
          ),
        );
      },
    );
  }
}
