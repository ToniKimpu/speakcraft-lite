import 'package:flutter/material.dart';
import 'package:pmp_english/bloc/youtube_player/youtube_player_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/chart_label_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/listening_practice_result_chart.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/score_level_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_widgets/user_answer_list_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../model/listening_question/listening_question.dart';

class ListeningPracticeResultPage extends StatefulWidget {
  const ListeningPracticeResultPage({
    super.key,
    required this.listening,
    required this.listeningQuestions,
    required this.listeningPracticeAnswers,
  });
  final Listening listening;
  final List<ListeningQuestion> listeningQuestions;
  final List<ListeningPracticeAnswer> listeningPracticeAnswers;

  @override
  State<ListeningPracticeResultPage> createState() =>
      _ListeningPracticeResultPageState();
}

class _ListeningPracticeResultPageState
    extends State<ListeningPracticeResultPage> {
  late int correctCount;
  late int inCorrectCount;
  late int notAnswerCount;
  late YoutubePlayerController _controller;
  Duration _position = Duration.zero;
  Duration _startDuration = Duration.zero;
  Duration _endDuration = Duration.zero;
  bool needSeek = true;
  final _youtubePlayerBloc = YoutubePlayerBloc();

  @override
  void initState() {
    super.initState();
    final answers = widget.listeningPracticeAnswers;
    correctCount =
        answers.where((e) => e.isCorrect && e.userAnswer != null).length;
    inCorrectCount =
        answers.where((e) => !e.isCorrect && e.userAnswer != null).length;
    notAnswerCount = answers.where((e) => e.userAnswer == null).length;

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
            setState(
              () {
                // debugPrint(
                //     "_controllerStateLogs: ${_controller.value.playerState.name} playerState!");
                _position = _controller.value.position;
                if (_position.inMilliseconds > _endDuration.inMilliseconds) {
                  _controller.pause();
                  needSeek = true;
                }
                _youtubePlayerBloc.add(
                  YoutubePlayerEvent.updatePlayerState(
                      _controller.value.playerState),
                );
              },
            );
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = _controller.value.playerState == PlayerState.buffering ||
        !_controller.value.isReady;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
        onReady: () {},
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: Stack(
            children: [
              Offstage(
                offstage: true,
                child: player,
              ),
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: Text(
                            'Test Result',
                            style: PmpTextStyles.h1
                                .copyWith(color: PmpColors.white),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ListeningPracticeResultChart(
                          correctCount: correctCount,
                          inCorrectCount: inCorrectCount,
                          notAnswerCount: notAnswerCount,
                        ),
                        const SizedBox(height: 18),
                        const ChartLabelWidget(),
                        const SizedBox(height: 32),
                        ScoreLevelWidget(
                          correctCount: correctCount,
                          inCorrectCount: inCorrectCount,
                          notAnswerCount: notAnswerCount,
                        ),
                        const SizedBox(height: 32),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: PmpColors.neutral300,
                        ),
                      ]),
                    ),
                  ),

                  /// 2️⃣ Sticky "Correct Answer" label
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyHeaderDelegate(
                      minHeight: 50,
                      maxHeight: 50,
                      child: Container(
                        color: const Color(0xFF203A43),
                        alignment: Alignment.center,
                        child: Text(
                          'Your Answers',
                          style: PmpTextStyles.body1Regular.copyWith(
                            color: PmpColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  UserAnswerListWidget(
                    youtubePlayerBloc: _youtubePlayerBloc,
                    listeningQuestions: widget.listeningQuestions,
                    listeningPracticeAnswers: widget.listeningPracticeAnswers,
                    controller: _controller,
                    onPlayAudio: (listeningQuestion) {
                      _startDuration = Duration(
                        milliseconds: (listeningQuestion.start * 1000).round(),
                      );
                      _endDuration = Duration(
                        milliseconds: (listeningQuestion.end * 1000).round(),
                      );
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
                      debugPrint(
                          "_onPlayAudioLogs: ${listeningQuestion.start} start!");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
