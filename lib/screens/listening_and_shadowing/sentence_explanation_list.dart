import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../model/sentence_explanation/sentence_explanation.dart';

class SentenceExplanationList extends StatefulWidget {
  const SentenceExplanationList({
    super.key,
    required this.listening,
  });

  final Listening listening;

  @override
  State<SentenceExplanationList> createState() =>
      _SentenceExplanationListState();
}

class _SentenceExplanationListState extends State<SentenceExplanationList> {
  late Future<List<SentenceExplanation>> _future;

  @override
  void initState() {
    super.initState();

    _future = fetchSentenceExplanations(
      widget.listening.subtitlePath,
    );
  }

  Future<List<SentenceExplanation>> fetchSentenceExplanations(
    String url,
  ) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load sentence explanations');
    }

    final decodedBody = utf8.decode(response.bodyBytes);
    final List data = jsonDecode(decodedBody);

    // ✅ Filter out null or empty explanation_url
    final filtered = data.where((e) {
      final url = e['explanation_url'];
      return url != null && url is String && url.trim().isNotEmpty;
    }).toList();

    return filtered.map((e) => SentenceExplanation.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        title: const Text("Sentence Explanations"),
      ),
      body: FutureBuilder<List<SentenceExplanation>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            AppLogger.instance.debug("_onFetchingError: ${snapshot.error?.toString()}");
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PmpColors.primary400.withValues(alpha: 0.15),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline,
                        size: 48,
                        color: PmpColors.primary400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Coming Soon",
                      style: PmpTextStyles.h1.copyWith(
                        color: PmpColors.white,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sentence explanation is on the way.\nStay tuned!",
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: PmpColors.white.withValues(alpha: 0.75),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
                    /// English sentence
                    Text(
                      item.english,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: PmpColors.neutral50,
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Burmese translation (soft background)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item.burmese,
                        style: const TextStyle(
                          fontSize: 14.5,
                          height: 1.6,
                          color: Colors.white,
                          fontFamily: 'Pyidaungsu', // important for Burmese
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "#${index + 1}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PmpRoutes.sentenceExplanationPage,
                                arguments: {
                                  "sentence_explanation": item,
                                },
                              );
                            },
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueAccent,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "See Explanation",
                                    style: PmpTextStyles.label2Regular.copyWith(
                                      color: PmpColors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Time row
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 10, vertical: 4),
                    //       decoration: BoxDecoration(
                    //         color: const Color(0xFF0EA5E9).withOpacity(0.12),
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       child: Text(
                    //         "⏱ ${item.start.toStringAsFixed(2)}s → ${item.end.toStringAsFixed(2)}s",
                    //         style: const TextStyle(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w500,
                    //           color: Color(0xFF0284C7),
                    //         ),
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     /// Optional: index badge
                    //     Text(
                    //       "#${index + 1}",
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.grey.shade500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
