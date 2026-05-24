import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/listening/listening.dart';

import '../../l10n/generated/l10n.dart';
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

    final filtered = data.where((e) {
      final url = e['explanation_url'];
      return url != null && url is String && url.trim().isNotEmpty;
    }).toList();

    return filtered.map((e) => SentenceExplanation.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Explanations'),
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
            AppLogger.instance
                .debug("_onFetchingError: ${snapshot.error?.toString()}");
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
                        color: colorScheme.surfaceContainerHighest,
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        size: 48,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Coming Soon',
                      style: PmpTextStyles.h1.copyWith(
                        color: colorScheme.onSurface,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sentence explanation is on the way.\nStay tuned!',
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurfaceVariant,
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
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.english,
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Text(
                        item.burmese,
                        style: TextStyle(
                          fontSize: 14.5,
                          height: 1.6,
                          color: colorScheme.onSurface,
                          fontFamily: 'Pyidaungsu',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PmpRoutes.sentenceExplanationPager,
                              arguments: {
                                'explanations': items,
                                'index': index,
                              },
                            );
                          },
                          icon: const Icon(Icons.arrow_forward, size: 16),
                          label: Text(
                            AppLocalizations.of(context).txtViewExplanation,
                            style: PmpTextStyles.label2Regular,
                          ),
                        ),
                      ],
                    ),
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
