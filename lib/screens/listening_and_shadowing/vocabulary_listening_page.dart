import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';

import '../../config/pmp_text_styles.dart';
import '../../model/listening/listening.dart';

class VocabularyListeningPage extends StatefulWidget {
  const VocabularyListeningPage({
    super.key,
    required this.listening,
  });
  final Listening listening;

  @override
  State<VocabularyListeningPage> createState() =>
      _VocabularyListeningPageState();
}

class _VocabularyListeningPageState extends State<VocabularyListeningPage> {
  final _subtitleBloc = SubtitleBloc();

  @override
  void initState() {
    super.initState();
    _subtitleBloc.add(SubtitleEvent.parseSubtitle(widget.listening));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _subtitleBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vocabularies'),
        ),
        body: BlocBuilder<SubtitleBloc, SubtitleState>(
          builder: (context, state) {
            return state.maybeWhen(
              onParsingSubtitle: (data) {
                final subtitles = data
                    .where((s) =>
                        s.vocabularies != null && s.vocabularies!.isNotEmpty)
                    .toList();
                if (subtitles.isEmpty) {
                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Total - ${subtitles.length}",
                        style: PmpTextStyles.body2Regular.copyWith(
                          fontFamily: "ArchivoBlack Regular",
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: subtitles.length,
                        itemBuilder: (context, index) {
                          final subtitle = subtitles[index];
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2)),
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
                              children: subtitle.vocabularies!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final vocabulary = entry.value;
                                final isLast =
                                    index == subtitle.vocabularies!.length - 1;

                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: isLast ? 0 : 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              vocabulary.english,
                                              style: PmpTextStyles.body2Semi
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            Text(
                                              vocabulary.burmese,
                                              style: PmpTextStyles.body2Semi
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 12,
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
    );
  }
}
