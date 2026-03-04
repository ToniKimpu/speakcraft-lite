import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_practice_answer/listening_practice_answer.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/sentence_practice_widget_two.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/sentence_practice_youtube_player.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/app_ui/app_ui_bloc.dart';
import '../../bloc/listening_practice_answer/listening_practice_answer_bloc.dart';
import '../../config/pmp_routes.dart';
import 'dialogs/checking_user_answers_dialog.dart';

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
  late final YoutubePlayerController _youtubeController;

  final _timeSpentNotifier = ValueNotifier<int>(0);
  final _userAnswers = <ListeningPracticeAnswer>[];
  AnswerOption? _selectedAnswerOption;
  Timer? _timer;

  int _currentPage = 0;
  int _totalQuestions = 0;
  Duration _position = Duration.zero;
  Duration _startDuration = Duration.zero;
  Duration _endDuration = Duration.zero;
  bool _needSeek = true;

  final _listeningPracticeAnswerBloc = ListeningPracticeAnswerBloc();

  BuildContext? _loadingDialogContext;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeDurationsForQuestion(0);
  }

  void _initializeControllers() {
    _totalQuestions = widget.listeningQuestions.length;
    _pageController = PageController(initialPage: _currentPage);

    _youtubeController = YoutubePlayerController(
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
      ),
    )..addListener(_onYoutubeControllerUpdate);
  }

  void _onYoutubeControllerUpdate() {
    if (!mounted) return;
    setState(() {
      _position = _youtubeController.value.position;
      if (_position.inMilliseconds > _endDuration.inMilliseconds) {
        _youtubeController.pause();
        _needSeek = true;
      }
    });
  }

  void _initializeDurationsForQuestion(int page) {
    final question = widget.listeningQuestions[page];
    _startDuration = Duration(milliseconds: (question.start * 1000).round());
    _endDuration = Duration(milliseconds: (question.end * 1000).round());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timeSpentNotifier.dispose();
    _youtubeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _goToNextPage(int page) {
    if (page >= widget.listeningQuestions.length) return;

    _initializeDurationsForQuestion(page);
    _youtubeController.pause();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() => _currentPage = page);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timeSpentNotifier.value++;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timeSpentNotifier.value = 0;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  ListeningPracticeAnswer _buildAnswer() {
    return ListeningPracticeAnswer(
      groupId: widget.groupId,
      questionId: _currentPage + 1,
      timeSpent: _timeSpentNotifier.value,
      userAnswer: _selectedAnswerOption?.answer,
      isCorrect: _selectedAnswerOption?.correct ?? false,
      youtubeId: widget.listening.youtubeId,
    );
  }

  void _handleAnswerSubmit({bool skipped = false}) {
    if (_youtubeController.value.isPlaying) {
      _youtubeController.pause();
    }
    _stopTimer();

    final answer = _buildAnswer();
    _userAnswers.add(answer);

    final isLastQuestion = _userAnswers.length == _totalQuestions;

    if (isLastQuestion) {
      // _showCheckDialog();
      _listeningPracticeAnswerBloc.add(
        ListeningPracticeAnswerEvent.saveUserAnswers(_userAnswers),
      );
    } else {
      setState(() => _selectedAnswerOption = null);
      _goToNextPage(_currentPage + 1);
    }
    AppLogger.instance.debug('_answerLogs: ${answer.toJson()}');
  }

  // void _showCheckDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) =>
  //         CheckingUserAnswersDialog(userAnswers: _userAnswers),
  //   ).then((confirmed) {
  //     if (confirmed == true && context.mounted) {
  //       context.read<AppUIBloc>().add(
  //             const AppUIEvent.reloadListeningPracticeList(),
  //           );
  //       Navigator.pushReplacementNamed(
  //         context,
  //         PmpRoutes.listeningPracticeResultPage,
  //         arguments: {
  //           "listening": widget.listening,
  //           "listening_answers": _userAnswers,
  //           "listening_questions": widget.listeningQuestions,
  //         },
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        _youtubeController.value.playerState == PlayerState.buffering ||
            !_youtubeController.value.isReady;

    return BlocListener<ListeningPracticeAnswerBloc,
        ListeningPracticeAnswerState>(
      bloc: _listeningPracticeAnswerBloc,
      listener: (context, state) {
        state.maybeWhen(
          loading: (message) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                _loadingDialogContext = context;
                return const CheckingUserAnswersDialog();
              },
            );
          },
          onSaved: () {
            if (_loadingDialogContext != null) {
              Navigator.pop(_loadingDialogContext!);
              _loadingDialogContext = null;
            }
            context.read<AppUIBloc>().add(
                  const AppUIEvent.reloadListeningPracticeList(),
                );
            Navigator.pushReplacementNamed(
              context,
              PmpRoutes.listeningPracticeResultPage,
              arguments: {
                "listening": widget.listening,
                "listening_answers": _userAnswers,
                "listening_questions": widget.listeningQuestions,
              },
            );
          },
          orElse: () => -1,
        );
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: false,
          onReady: _startTimer,
        ),
        builder: (context, player) {
          return MainScaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: buildHeader(),
            ),
            body: Column(
              children: [
                buildVideoPlayer(player, isLoading),
                const SizedBox(height: 8),
                buildQuestionPageView(),
                buildBottomActions(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              const SizedBox(width: 8),
              ValueListenableBuilder<int>(
                valueListenable: _timeSpentNotifier,
                builder: (_, seconds, __) => Text(
                  _formatDuration(seconds),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Text("${_currentPage + 1}/$_totalQuestions"),
      ],
    );
  }

  Widget buildVideoPlayer(Widget player, bool isLoading) {
    return SentencePracticeYoutubePlayer(
      player: player,
      listening: widget.listening,
      controller: _youtubeController,
      currentPage: _currentPage,
      onTap: () {
        if (isLoading) return;
        if (_youtubeController.value.isPlaying) {
          _needSeek = false;
          _youtubeController.pause();
        } else {
          if (_needSeek) {
            _youtubeController.seekTo(_startDuration);
          }
          _youtubeController.play();
        }
      },
    );
  }

  Widget buildQuestionPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.listeningQuestions.length,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _startTimer();
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          final question = widget.listeningQuestions[index];
          return SentencePracticeWidgetTwo(
            answerOption: _selectedAnswerOption,
            listeningQuestion: question,
            onAnswerSelected: (option) {
              setState(() => _selectedAnswerOption = option);
            },
          );
        },
      ),
    );
  }

  Widget buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: buildActionButton(
              label: "Skip",
              color: Colors.grey.shade600,
              onPressed: () => _handleAnswerSubmit(skipped: true),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: buildActionButton(
              label: "Confirm",
              color: _selectedAnswerOption == null
                  ? Colors.blue.withValues(alpha: 0.4)
                  : Colors.blue,
              textColor: _selectedAnswerOption == null
                  ? Colors.white.withValues(alpha: 0.4)
                  : Colors.white,
              onPressed:
                  _selectedAnswerOption == null ? null : _handleAnswerSubmit,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton({
    required String label,
    required Color color,
    Color textColor = Colors.white,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Ink(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
          ),
          child: Center(
            child: Text(
              label,
              style: PmpTextStyles.body1Regular.copyWith(
                color: textColor,
                fontFamily: "ArchivoBlack Regular",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
