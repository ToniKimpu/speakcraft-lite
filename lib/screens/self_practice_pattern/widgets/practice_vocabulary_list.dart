import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/pattern/pattern_bloc.dart';
import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class PracticeVocabularyList extends StatelessWidget {
  const PracticeVocabularyList({
    super.key,
    required ValueNotifier<bool> showVocabularyNotifier,
    required double popupHeight,
    required PatternBloc vocabularyBloc,
  })  : _showVocabularyNotifier = showVocabularyNotifier,
        _popupHeight = popupHeight,
        _vocabularyBloc = vocabularyBloc;

  final ValueNotifier<bool> _showVocabularyNotifier;
  final double _popupHeight;
  final PatternBloc _vocabularyBloc;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showVocabularyNotifier,
      builder: (context, showVocabulary, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: 16,
          right: 16,
          bottom: showVocabulary ? 24 : -1000,
          child: child!,
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: _popupHeight,
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 10,
              ),
            ],
          ),
          child: BlocBuilder<PatternBloc, PatternState>(
            bloc: _vocabularyBloc,
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                vocabularyLoaded: (vocabularies) {
                  if (vocabularies.isEmpty) {
                    return Center(
                      child: Text(
                        'သည်စကားစုအတွက် vocabularyများ မကြာခင်ထည့်ပေးပါမည်။',
                        style: PmpTextStyles.body1Regular.copyWith(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vocabularies',
                            style: PmpTextStyles.body2Medium.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(18),
                            color: PmpColors.primary400,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () {
                                _showVocabularyNotifier.value = false;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 0.5,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'သည်စကားလုံးတွေကို အသုံးပြုပြီး လေ့ကျင့်လို့ရပါတယ်။',
                        style: PmpTextStyles.body2Medium.copyWith(
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: vocabularies.length,
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          itemBuilder: (context, index) {
                            final vocabulary = vocabularies[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: PmpColors.primary400,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vocabulary.englishText,
                                        style:
                                            PmpTextStyles.body2Medium.copyWith(
                                          color: Colors.black,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        vocabulary.burmeseText,
                                        style:
                                            PmpTextStyles.body2Medium.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 6,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
        ),
      ),
    );
  }
}
