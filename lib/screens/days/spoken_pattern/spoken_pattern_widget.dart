import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/practice_label_widget.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/spoken_pattern_example_list.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/spoken_pattern_header.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/svg_data_widget.dart';

import '../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../bloc/user_example_answer/user_example_answer_bloc.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/pattern_example/pattern_example.dart';
import '../../../model/spoken_pattern/spoken_pattern.dart';
import 'widgets/spoken_pattern_example_practice.dart';

class SpokenPatternWidget extends StatefulWidget {
  const SpokenPatternWidget({
    super.key,
    required this.audioPlayer,
    required this.spokenPattern,
    required this.audioPositionTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.onNextEnabledChanged,
  });
  final AudioPlayer audioPlayer;
  final SpokenPattern spokenPattern;
  final AudioPlayerBloc audioPositionTrackerBloc, audioPlayerStateTrackerBloc;
  final Function(int spokenpatternId) onNextEnabledChanged;

  @override
  State<SpokenPatternWidget> createState() => _SpokenPatternWidgetState();
}

class _SpokenPatternWidgetState extends State<SpokenPatternWidget> {
  late List<PatternExample> patternExamples;
  // late List<PatternExample> practicePatternExamples;

  final _spokenPatternBloc = SpokenPatternBloc();
  late final UserExampleAnswerBloc _userExampleAnswerBloc;

  String _currentPlayingId = "-1";

  @override
  void initState() {
    super.initState();
    final examples = widget.spokenPattern.patternExamples ?? <PatternExample>[];
    _userExampleAnswerBloc = UserExampleAnswerBloc();
    patternExamples = examples
        .where((example) => example.practicable == false)
        .toList()
      ..sort((a, b) =>
          (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));

    _spokenPatternBloc.add(
      SpokenPatternEvent.loadPracticeExamplesByPattern(
          withLoading: true, patternId: widget.spokenPattern.id!),
    );

    // practicePatternExamples = examples
    //     .where((example) => example.practicable == true)
    //     .toList()
    //   ..sort((a, b) =>
    //       (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));
  }

  @override
  void dispose() {
    _spokenPatternBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserExampleAnswerBloc, UserExampleAnswerState>(
      bloc: _userExampleAnswerBloc,
      listener: (context, state) {
        state.maybeWhen(
          loaded: (userAnswer) {
            _spokenPatternBloc
                .add(SpokenPatternEvent.loadPracticeExamplesByPattern(
              withLoading: false,
              patternId: widget.spokenPattern.id!,
            ));
          },
          orElse: () => -1,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.spokenPattern.pattern,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'ArchivoBlack Regular',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.spokenPattern.title?.isNotEmpty ?? false)
                            Text(
                              widget.spokenPattern.title!,
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                      bloc: widget.audioPlayerStateTrackerBloc,
                      builder: (context, audioPlayerState) {
                        final currentPlayerState = audioPlayerState.maybeWhen(
                          onUpdatePlayerState: (playerState) => playerState,
                          orElse: () => null,
                        );
                        return SpokenPatternHeader(
                          audioPlayer: widget.audioPlayer,
                          spokenPattern: widget.spokenPattern,
                          currentPlayerState: currentPlayerState,
                          currentPlayingId: _currentPlayingId,
                          onCurrentPlayingIdChanged: (value) {
                            setState(() {
                              _currentPlayingId = value;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.spokenPattern.subjectVerbAgreement != null &&
                      widget.spokenPattern.subjectVerbAgreement!.svgData
                          .isNotEmpty)
                    SvgDataWidget(spokenPattern: widget.spokenPattern),
                  if (patternExamples.isNotEmpty)
                    BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                      bloc: widget.audioPlayerStateTrackerBloc,
                      builder: (context, audioPlayerState) {
                        final currentPlayerState = audioPlayerState.maybeWhen(
                          onUpdatePlayerState: (playerState) => playerState,
                          orElse: () => null,
                        );
                        return SpokenPatternExampleList(
                          patternExamples: patternExamples,
                          audioPlayer: widget.audioPlayer,
                          audioPlayerStateTrackerBloc:
                              widget.audioPositionTrackerBloc,
                          currentPlayerState: currentPlayerState,
                          currentPlayingId: _currentPlayingId,
                          onCurrentPlayingIdChanged: (currentPlayingId) {
                            setState(() {
                              _currentPlayingId = currentPlayingId;
                            });
                          },
                        );
                      },
                    ),
                  BlocConsumer<SpokenPatternBloc, SpokenPatternState>(
                    bloc: _spokenPatternBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        examplesLoaded: (practicePatternExamples) {
                          final allAnswered = practicePatternExamples.every(
                            (e) => (e.userAnswer ?? '').isNotEmpty,
                          );
                          if (allAnswered) {
                            widget.onNextEnabledChanged(
                              widget.spokenPattern.id ?? -1,
                            );
                          }
                        },
                        orElse: () => -1,
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                        examplesLoaded: (practicePatternExamples) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const PracticeLabelWidget(),
                              BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                                bloc: widget.audioPlayerStateTrackerBloc,
                                builder: (context, audioPlayerState) {
                                  final currentPlayerState =
                                      audioPlayerState.maybeWhen(
                                    onUpdatePlayerState: (playerState) =>
                                        playerState,
                                    orElse: () => null,
                                  );
                                  return ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: practicePatternExamples.length,
                                    padding: const EdgeInsets.all(16),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final patternExample =
                                          practicePatternExamples[index];
                                      return SpokenPatternExamplePractice(
                                        spokenPatternExample: patternExample,
                                        audioPlayer: widget.audioPlayer,
                                        currentPlayingId: _currentPlayingId,
                                        currentPlayerState: currentPlayerState,
                                        onCurrentPlayingIdChanged:
                                            (currentPlayingId) {
                                          setState(() {
                                            _currentPlayingId =
                                                currentPlayingId;
                                          });
                                        },
                                        onDone: (_) {},
                                        onAnswerChanged: (exampleId, answer) {
                                          _userExampleAnswerBloc.add(
                                            UserExampleAnswerEvent.insert(
                                              exampleId,
                                              answer,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 8),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        orElse: () => Container(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
