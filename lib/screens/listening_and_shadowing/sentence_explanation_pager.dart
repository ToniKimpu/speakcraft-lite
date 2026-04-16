import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/footer_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_explanation_json_view.dart';

class SentenceExplanationPager extends StatefulWidget {
  const SentenceExplanationPager({
    super.key,
    required this.explanations,
    required this.initialIndex,
  });

  final List<SentenceExplanation> explanations;
  final int initialIndex;

  @override
  State<SentenceExplanationPager> createState() =>
      _SentenceExplanationPagerState();
}

class _SentenceExplanationPagerState extends State<SentenceExplanationPager> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
            Icon(Icons.lightbulb_outline, color: Colors.amberAccent),
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.explanations.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _ExplanationPageContent(
                  explanation: widget.explanations[index],
                );
              },
            ),
          ),
          FooterWidget(
            totalPage: widget.explanations.length,
            currentPage: _currentPage,
            nextEnabled: true,
            onPageChanged: (index) {
              _pageController.jumpToPage(index);
              setState(() => _currentPage = index);
            },
          ),
        ],
      ),
    );
  }
}

class _ExplanationPageContent extends StatefulWidget {
  const _ExplanationPageContent({required this.explanation});
  final SentenceExplanation explanation;

  @override
  State<_ExplanationPageContent> createState() =>
      _ExplanationPageContentState();
}

class _ExplanationPageContentState extends State<_ExplanationPageContent>
    with AutomaticKeepAliveClientMixin {
  Map<String, dynamic>? _jsonData;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

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
          Env.bunnyListeningAPIKey + widget.explanation.explanationUrl;
      AppLogger.instance.debug("_loadJson: $url");

      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 404) {
        throw const _FriendlyException('Explanation not found.');
      }
      if (response.statusCode != 200) {
        throw const _FriendlyException(
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
    } on _FriendlyException catch (e) {
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
    super.build(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return _ErrorView(message: _errorMessage!, onRetry: _loadJson);
    }
    if (_jsonData != null) {
      return SentenceExplanationJsonView(data: _jsonData!);
    }
    return const SizedBox.shrink();
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
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
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
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

class _FriendlyException implements Exception {
  final String message;
  const _FriendlyException(this.message);
}
