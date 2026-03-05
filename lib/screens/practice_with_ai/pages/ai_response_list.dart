import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pmp_english/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/shared_widgets/empty_widget.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../model/ai_sentence_practice/ai_sentence_practice.dart';

class AiReponseList extends StatelessWidget {
  const AiReponseList({
    super.key,
    required this.aiSentencePracticeBloc,
    this.onNeedReload,
  });
  final AiSentencePracticeBloc aiSentencePracticeBloc;
  final VoidCallback? onNeedReload;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiSentencePracticeBloc, AiSentencePracticeState>(
      bloc: aiSentencePracticeBloc,
      builder: (context, state) {
        return state.maybeWhen(
          loading: (message) {
            return const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              ),
            );
          },
          loadedGroupData: (aiResponseGroup) {
            if (aiResponseGroup.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: EmptyWidget(
                  message:
                      "You haven't practiced any sentences yet. Start practicing to see your progress here.",
                ),
              );
            }
            return buildGroupedList(aiResponseGroup);
          },
          orElse: () => Container(),
        );
      },
    );
  }

  Widget buildGroupedList(
      Map<DateTime, List<AiSentencePractice>> aiResponseGroup) {
    final groupedEntries = aiResponseGroup.entries.toList();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 8,
          ),
        ),
        SliverList.separated(
          itemCount: groupedEntries.length,
          itemBuilder: (context, index) {
            final entry = groupedEntries[index];
            final date = entry.key;
            final items = entry.value;

            return Card(
              elevation: 6,
              color: const Color(0xFF1C2C3C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📅 Date Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      "📅   ${DateFormat('dd MMM yyyy').format(date)}",
                      style: PmpTextStyles.labelSemi.copyWith(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  // Divider
                  Divider(
                    color: Colors.white.withValues(alpha: 0.15),
                    thickness: 1,
                    height: 0,
                  ),

                  // 📋 Sentence List
                  ...items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isLast = index == items.length - 1;

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: isLast
                            ? const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              )
                            : null,
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            PmpRoutes.aiResponseDetailScreen,
                            arguments: {
                              "aiSentencePractice": item,
                            },
                          );
                          if (result == true) {
                            onNeedReload?.call();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.inputSentence,
                                  style: PmpTextStyles.body2Semi.copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: 12), // spacing between cards
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
          ),
        ),
      ],
    );
  }
}
