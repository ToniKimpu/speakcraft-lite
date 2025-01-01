import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/translation_day/translation_day_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/translation_day/translation_day.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';

class TranslationDayList extends StatefulWidget {
  const TranslationDayList({
    super.key,
    required this.translationLevelId,
  });
  final int translationLevelId;

  @override
  State<TranslationDayList> createState() => _TranslationDayListState();
}

class _TranslationDayListState extends State<TranslationDayList> {
  @override
  void initState() {
    super.initState();
    context.read<TranslationDayBloc>().add(
          TranslationDayEvent.loadTranslationDays(widget.translationLevelId),
        );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 1'),
      ),
      body: BlocBuilder<TranslationDayBloc, TranslationDayState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              ),
            ),
            loaded: (translationDays) {
              if (translationDays.isEmpty) {
                return Center(
                  child: Text(
                    'မကြာခင် သင်ခန်းစာများထည့်ပေးပါမည်။',
                    style: PmpTextStyles.body2Semi.copyWith(
                      color: Colors.black,
                    ),
                  ),
                );
              }
              bool foundFirstIncomplete = false;
              return GridView.builder(
                itemCount: translationDays.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 4 / 5.3,
                ),
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final translationDay = translationDays[index];
                  bool isOpenIndex =
                      !translationDay.isComplete && !foundFirstIncomplete;
                  if (isOpenIndex) {
                    foundFirstIncomplete = true;
                  }
                  return _buildDayWidget(
                    translationDay,
                    isOpenIndex,
                    index + 1,
                  );
                },
              );
            },
            orElse: () => Container(),
          );
        },
      ),
    );
  }

  _buildDayWidget(TranslationDay translationDay, bool isOpenIndex, int index) {
    return Column(
      children: [
        Material(
          color: translationDay.isComplete
              ? PmpColors.primary400
              : isOpenIndex
                  ? Colors.green
                  : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _isDisable(translationDay.isComplete, isOpenIndex)
                ? null
                : () {
                    if (translationDay.isComplete) {
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.translationPracticeResultScreen,
                        arguments: {
                          'translation_day_id': translationDay.id,
                        },
                      );
                      return;
                    }
                    Navigator.pushNamed(
                      context,
                      PmpRoutes.translationPage,
                      arguments: {
                        'translation_day': translationDay,
                      },
                    );
                  },
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Center(
                child: Icon(
                  translationDay.isComplete
                      ? Icons.check_circle
                      : isOpenIndex
                          ? Icons.play_circle
                          : Icons.lock_open,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Expanded(
          child: Text(
            'D - ${index.toString().padLeft(2, '0')}',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  _isDisable(bool isComplete, bool isOpenIndex) {
    return !isComplete && !isOpenIndex;
  }
}
