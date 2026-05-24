import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_json_view.dart';

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
  Map<String, dynamic>? _jsonData;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _jsonData = null;
    });

    try {
      final url =
          Env.bunnyListeningAPIKey + widget.sentenceExplanation.explanationUrl;

      AppLogger.instance.debug("_loadJson: $url");

      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 404) {
        throw const _UserFriendlyException('Explanation not found.');
      }

      if (response.statusCode != 200) {
        throw const _UserFriendlyException(
          'Failed to load explanation. Please try again later.',
        );
      }

      final data =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (!mounted) return;

      setState(() {
        _jsonData = data;
        _isLoading = false;
      });
    } on TimeoutException {
      _setError('Connection timed out. Please try again.');
    } on http.ClientException {
      _setError('Network error. Please check your internet connection.');
    } on _UserFriendlyException catch (e) {
      _setError(e.message);
    } catch (_) {
      _setError('Something went wrong while loading this explanation.');
    }
  }

  void _setError(String message) {
    if (!mounted) return;

    setState(() {
      _errorMessage = message;
      _isLoading = false;
      _jsonData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Colors.amberAccent,
            ),
            SizedBox(width: 6),
            Text(
              'Explanation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.amberAccent,
                fontFamily: 'ArchivoBlack Regular',
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _ErrorView(
                  message: _errorMessage!,
                  onRetry: _loadJson,
                )
              : _jsonData != null
                  ? SentenceExplanationJsonView(data: _jsonData!)
                  : const SizedBox.shrink(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                color: theme.colorScheme.error.withValues(alpha: 0.15),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 52,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "Couldn't load explanation",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Try again"),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserFriendlyException implements Exception {
  final String message;
  const _UserFriendlyException(this.message);
}
