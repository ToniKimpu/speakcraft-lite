import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/pattern_exercise/pattern_exercise_bloc.dart';
import 'package:pmp_english/model/pattern_exercise/pattern_exercise.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';

class PatternPracticeResultScreen extends StatefulWidget {
  const PatternPracticeResultScreen({
    super.key,
    this.patternExercises,
    this.exerciseId,
  });

  final List<PatternExercise>? patternExercises;
  final int? exerciseId;

  @override
  State<PatternPracticeResultScreen> createState() =>
      _PatternPracticeResultScreenState();
}

class _PatternPracticeResultScreenState
    extends State<PatternPracticeResultScreen> {
  final _patternExerciseBloc = PatternExerciseBloc();

  @override
  void initState() {
    super.initState();
    if (widget.exerciseId != null) {
      _patternExerciseBloc.add(
        PatternExerciseEvent.loadPatternExercisesWithAnswers(
            widget.exerciseId!),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.exerciseId != null) {
      return BlocProvider(
        create: (context) => _patternExerciseBloc,
        child: BlocBuilder<PatternExerciseBloc, PatternExerciseState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (patternExercises) {
                if (patternExercises.isEmpty) {
                  return const Center(
                    child: Text('No result'),
                  );
                }
                return _buildResultList(patternExercises);
              },
              orElse: () => Container(),
            );
          },
        ),
      );
    }
    return _buildResultList(widget.patternExercises!);
  }

  _buildResultList(List<PatternExercise> patternExercises) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: patternExercises.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _buildResultItem(
            patternExercises[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }

  _buildResultItem(PatternExercise patternExercise) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: PmpColors.neutral10.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Burmese',
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.black,
                ),
              ),
              if (patternExercise.audioPath != null)
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: PmpColors.primary400,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            patternExercise.burmeseText,
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'English',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            patternExercise.englishText,
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Your Answer:',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            patternExercise.userAnswer ?? "-",
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
