import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';

class HtmlPreview extends StatefulWidget {
  final String? assetPath;
  final String? title;
  final SentenceExplanation? sentenceExplanation;

  const HtmlPreview({
    super.key,
    this.assetPath,
    this.title,
    this.sentenceExplanation,
  });

  @override
  State<HtmlPreview> createState() => _HtmlPreviewState();
}

class _HtmlPreviewState extends State<HtmlPreview> {
  String? _htmlContent;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _htmlContent = null;
    });

    try {
      if (widget.assetPath != null) {
        // Load from assets
        AppLogger.instance.debug("_loadHtml from asset: ${widget.assetPath}");
        final String content = await rootBundle.loadString(widget.assetPath!);

        if (!mounted) return;

        setState(() {
          _htmlContent = content;
          _isLoading = false;
        });
      } else if (widget.sentenceExplanation != null) {
        // Load from network
        final url = Env.bunnyListeningAPIKey +
            widget.sentenceExplanation!.explanationUrl;

        AppLogger.instance.debug("_loadHtml from network: $url");

        final response =
            await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));

        if (response.statusCode == 404) {
          throw const _UserFriendlyException(
            'Explanation not found.',
          );
        }

        if (response.statusCode != 200) {
          throw const _UserFriendlyException(
            'Failed to load explanation. Please try again later.',
          );
        }

        final decodedHtml = utf8.decode(response.bodyBytes);

        if (!mounted) return;

        setState(() {
          _htmlContent = decodedHtml;
          _isLoading = false;
        });
      } else {
        throw const _UserFriendlyException(
          'No content source provided.',
        );
      }
    } on TimeoutException {
      _setError(
        'Connection timed out. Please try again.',
      );
    } on http.ClientException {
      _setError(
        'Network error. Please check your internet connection.',
      );
    } on _UserFriendlyException catch (e) {
      _setError(e.message);
    } catch (e) {
      AppLogger.instance.error("Error loading HTML: $e", error: e);
      _setError(
        'Something went wrong while loading this explanation.',
      );
    }
  }

  void _setError(String message) {
    if (!mounted) return;

    setState(() {
      _errorMessage = message;
      _isLoading = false;
      _htmlContent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // removes back arrow
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min, // <-- key for centering
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: Colors.amberAccent,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                widget.title ?? 'Explanation',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.amberAccent,
                  fontFamily: 'ArchivoBlack Regular',
                ),
                overflow: TextOverflow.ellipsis,
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
                  onRetry: _loadHtml,
                )
              : _htmlContent != null
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: HtmlWidget(
                        _htmlContent!,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.8),
                      ),
                    )
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
            // Icon bubble
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.error.withOpacity(0.15),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 52,
                color: theme.colorScheme.error,
              ),
            ),

            const SizedBox(height: 22),

            // Headline
            Text(
              "Couldn’t load explanation",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // Retry button
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
