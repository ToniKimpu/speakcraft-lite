import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ListeningVocabularyList extends StatelessWidget {
  const ListeningVocabularyList({
    super.key,
    required ValueNotifier<bool> showVocabularyNotifier,
    required ListeningBloc vocabularyBloc,
  })  : _showVocabularyNotifier = showVocabularyNotifier,
        _vocabularyBloc = vocabularyBloc;

  final ValueNotifier<bool> _showVocabularyNotifier;

  final ListeningBloc _vocabularyBloc;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showVocabularyNotifier,
      builder: (context, showVocabulary, child) {
        return Offstage(
          offstage: !showVocabulary,
          child: child!,
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 0, right: 0, top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.3), // Slightly stronger shadow
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            border: Border.all(
              color: Colors.white
                  .withValues(alpha: 0.4), // Soft white border for contrast
            ),
          ),
          child: BlocBuilder<ListeningBloc, ListeningState>(
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
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'သည်ဗီဒီယိုအတွက် vocabularyများ\n မကြာခင်တင်ပေးပါမည်။',
                          style: PmpTextStyles.body1Regular.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vocabularies',
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.orange,
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
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 0.5,
                        width: double.infinity,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: vocabularies.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final vocabulary = vocabularies[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: PmpColors.white,
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
                                          color: Colors.white,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        vocabulary.burmeseText,
                                        style:
                                            PmpTextStyles.body2Medium.copyWith(
                                          color: Colors.white,
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
