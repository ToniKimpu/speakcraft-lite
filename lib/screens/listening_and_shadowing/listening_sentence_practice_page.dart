import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_practice_answer/listening_practice_answer.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/sentence_practice_widget_two.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/sentence_practice_youtube_player.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListeningSentencePracticePage extends StatefulWidget {
  const ListeningSentencePracticePage({
    super.key,
    required this.complete,
    required this.listening,
    required this.listeningQuestions,
    required this.groupId,
  });
  final bool complete;
  final Listening listening;
  final List<ListeningQuestion> listeningQuestions;
  final String groupId;

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
  Duration _startDuration = Duration.zero;
  Duration _endDuration = Duration.zero;
  bool needSeek = true;

  final _timeSpentNotifier = ValueNotifier<int>(0);
  AnswerOption? _selectedAnswerOption;
  Timer? timer;
  final _userAnswers = <ListeningPracticeAnswer>[];
  int _totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    _totalQuestions = widget.listeningQuestions.length;
    _pageController = PageController(initialPage: _currentPage);
    _controller = YoutubePlayerController(
      initialVideoId: widget.listening.youtubeId,
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
              // debugPrint(
              //     "_controllerStateLogs: ${_controller.value.playerState.name} playerState!");
              _position = _controller.value.position;
              if (_position.inMilliseconds > _endDuration.inMilliseconds) {
                _controller.pause();
                needSeek = true;
              }
            });
          }
        },
      );
    _startDuration = Duration(
      milliseconds: (widget.listeningQuestions.first.start * 1000).round(),
    );
    _endDuration = Duration(
      milliseconds: (widget.listeningQuestions.first.end * 1000).round(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timeSpentNotifier.dispose();
    timer?.cancel();
    super.dispose();
  }

  void _goToNextPage(int page) {
    if (page >= 0 && page < widget.listeningQuestions.length) {
      _startDuration = Duration(
        milliseconds: (widget.listeningQuestions[page].start * 1000).round(),
      );
      _endDuration = Duration(
        milliseconds: (widget.listeningQuestions[page].end * 1000).round(),
      );
      _controller.pause();
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage = page);
    }
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String twoDigitMinutes = minutes.toString().padLeft(2, '0');
    String twoDigitSeconds = remainingSeconds.toString().padLeft(2, '0');
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      debugPrint('in timer tick!');
      _timeSpentNotifier.value = 1 + _timeSpentNotifier.value;
    });
  }

  void _stopTimer() {
    timer?.cancel();
    _timeSpentNotifier.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    bool loading = _controller.value.playerState == PlayerState.buffering ||
        !_controller.value.isReady;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
        onReady: () {
          // _isPlayerReady = true;
          _startTimer();
        },
      ),
      builder: (context, player) {
        return MainScaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/timer.png',
                        width: 13,
                        height: 13,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _timeSpentNotifier,
                        builder: (context, second, child) {
                          return Text(
                            _formatDuration(second),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Text("${_currentPage + 1}/${widget.listeningQuestions.length}"),
              ],
            ),
          ),
          body: Column(
            children: [
              SentencePracticeYoutubePlayer(
                player: player,
                listening: widget.listening,
                controller: _controller,
                currentPage: _currentPage,
                onTap: () {
                  if (loading) return;
                  if (_controller.value.isPlaying) {
                    needSeek = false;
                    _controller.pause();
                    return;
                  }
                  if (needSeek) {
                    _controller.seekTo(_startDuration);
                  }
                  _controller.play();
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.listeningQuestions.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    _startTimer();
                    setState(
                      () => _currentPage = index,
                    );
                  },
                  itemBuilder: (context, index) {
                    final listeningQuestion = widget.listeningQuestions[index];
                    return SentencePracticeWidgetTwo(
                      answerOption: _selectedAnswerOption,
                      listeningQuestion: listeningQuestion,
                      onAnswerSelected: (answerOption) {
                        setState(
                          () => _selectedAnswerOption = answerOption,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            }
                            _stopTimer();
                            final listeningPracticeAnswer =
                                ListeningPracticeAnswer(
                              groupId: widget.groupId,
                              questionId: _currentPage + 1,
                              timeSpent: _timeSpentNotifier.value,
                              userAnswer: _selectedAnswerOption?.answer,
                              isCorrect:
                                  _selectedAnswerOption?.correct ?? false,
                            );
                            _userAnswers.add(
                              listeningPracticeAnswer,
                            );
                            if (_totalQuestions == _userAnswers.length) {
                              Navigator.pushNamed(
                                context,
                                PmpRoutes.listeningPracticeResultPage,
                                arguments: {
                                  "listening": widget.listening,
                                  "listening_answers": _userAnswers,
                                  "listening_questions":
                                      widget.listeningQuestions,
                                },
                              );
                              return;
                            }
                            setState(() {
                              _selectedAnswerOption = null;
                            });
                            _goToNextPage(_currentPage + 1);
                          },
                          child: Ink(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade600,
                            ),
                            child: Center(
                              child: Text(
                                "Skip",
                                style: PmpTextStyles.body1Regular.copyWith(
                                  color: Colors.white,
                                  fontFamily: "ArchivoBlack Regular",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _selectedAnswerOption == null
                              ? null
                              : () {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  }
                                  _stopTimer();
                                  final listeningPracticeAnswer =
                                      ListeningPracticeAnswer(
                                    groupId: widget.groupId,
                                    questionId: _currentPage + 1,
                                    timeSpent: _timeSpentNotifier.value,
                                    userAnswer: _selectedAnswerOption?.answer,
                                    isCorrect:
                                        _selectedAnswerOption?.correct ?? false,
                                  );
                                  _userAnswers.add(
                                    listeningPracticeAnswer,
                                  );
                                  if (_totalQuestions == _userAnswers.length) {
                                    Navigator.pushNamed(
                                      context,
                                      PmpRoutes.listeningPracticeResultPage,
                                      arguments: {
                                        "listening": widget.listening,
                                        "listening_answers": _userAnswers,
                                        "listening_questions":
                                            widget.listeningQuestions,
                                      },
                                    );
                                    return;
                                  }
                                  setState(() {
                                    _selectedAnswerOption = null;
                                  });
                                  _goToNextPage(_currentPage + 1);
                                  debugPrint(
                                      "_listeningPracticeAnswerLogs: ${listeningPracticeAnswer.toJson()}");
                                },
                          child: Ink(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: _selectedAnswerOption == null
                                  ? Colors.blue.withValues(alpha: 0.4)
                                  : Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: PmpTextStyles.body1Regular.copyWith(
                                  color: _selectedAnswerOption == null
                                      ? Colors.white.withValues(alpha: 0.4)
                                      : Colors.white,
                                  fontFamily: "ArchivoBlack Regular",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
