import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';

class SentenceExplanationPage extends StatefulWidget {
  const SentenceExplanationPage({
    super.key,
    required this.sentenceExplanation,
  });

  final SentenceExplanation sentenceExplanation;

  @override
  State<SentenceExplanationPage> createState() =>
      _SentenceExplanationPageState();
}

class _SentenceExplanationPageState extends State<SentenceExplanationPage> {
  String? _htmlContent;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    try {
      String url =
          Env.bunnyListeningAPIKey + widget.sentenceExplanation.explanationUrl;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load explanation');
      }
      // ✅ Force UTF-8 decoding (important!)
      final decodedHtml = utf8.decode(response.bodyBytes);

      setState(() {
        _htmlContent = decodedHtml;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Sentence Explanation'),
          ),
      body: _error != null
          ? Center(
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : _htmlContent == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: HtmlWidget(
                    _htmlContent!,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.8,
                        ),
                  ),
                ),
    );
  }
}
