import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/listening_practice_answer/listening_practice_answer_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening_practice_answer/listening_practice_answer.dart';

class CheckingUserAnswersDialog extends StatelessWidget {
  const CheckingUserAnswersDialog({
    super.key,
    required this.userAnswers,
  });
  final List<ListeningPracticeAnswer> userAnswers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListeningPracticeAnswerBloc()
        ..add(
          ListeningPracticeAnswerEvent.saveUserAnswers(userAnswers),
        ),
      child: AlertDialog(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.zero,
        content: BlocListener<ListeningPracticeAnswerBloc,
            ListeningPracticeAnswerState>(
          listener: (context, state) {
            state.maybeWhen(
              onSaved: () {
                debugPrint(
                    "_checkingUserAnswerDialogLogs: on Saved is called!");
                Navigator.of(context).pop(true);
              },
              orElse: () => -1,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF203A43),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Checking your answers",
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.white,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
