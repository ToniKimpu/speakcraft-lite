import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/guest_gate.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/repositories/youtube_import/youtube_import_repository.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_json_view.dart';

class SentenceExplanationPage extends StatefulWidget {
  const SentenceExplanationPage({
    super.key,
    required this.sentenceExplanation,
    this.importId = '',
  });

  final SentenceExplanation sentenceExplanation;

  /// Non-empty for imported videos — if this sentence has no explanation yet,
  /// generate it on demand (yt-enrich) instead of failing.
  final String importId;

  @override
  State<SentenceExplanationPage> createState() =>
      _SentenceExplanationPageState();
}

class _SentenceExplanationPageState extends State<SentenceExplanationPage> {
  final _importRepo = YoutubeImportRepository();
  Map<String, dynamic>? _jsonData;
  _ExplanationError? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _jsonData = null;
    });

    try {
      final eu = widget.sentenceExplanation.explanationUrl;

      // Imported videos with no explanation yet: generate this one on demand.
      if (eu.isEmpty) {
        if (widget.importId.isEmpty) {
          throw const _UserFriendlyException(_ExplanationError.notFound);
        }
        // Generating an explanation runs Gemini; guests must create an account.
        // This page auto-loads, so prompt post-frame and surface an error state.
        if (isGuestUser()) {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                showGuestAccountSheet(context, featureName: 'AI explanation');
              }
            });
          }
          throw const _UserFriendlyException(_ExplanationError.loadFailed);
        }
        final res = await _importRepo.enrich(
          importId: widget.importId,
          step: 'explanation',
          lineId: widget.sentenceExplanation.id,
        );
        if (res.data == null) {
          throw const _UserFriendlyException(_ExplanationError.loadFailed);
        }
        if (!mounted) return;
        setState(() {
          _jsonData = res.data;
          _isLoading = false;
        });
        return;
      }

      // Imported videos store an absolute Supabase URL; curated content stores
      // a Bunny-relative path. Only prepend the Bunny base for the latter.
      final url = eu.startsWith('http') ? eu : Env.bunnyListeningAPIKey + eu;

      AppLogger.instance.debug("_loadJson: $url");

      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));

      if (response.statusCode == 404) {
        throw const _UserFriendlyException(_ExplanationError.notFound);
      }

      if (response.statusCode != 200) {
        throw const _UserFriendlyException(_ExplanationError.loadFailed);
      }

      final data =
          json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      if (!mounted) return;

      setState(() {
        _jsonData = data;
        _isLoading = false;
      });
    } on TimeoutException {
      _setError(_ExplanationError.timeout);
    } on http.ClientException {
      _setError(_ExplanationError.network);
    } on _UserFriendlyException catch (e) {
      _setError(e.kind);
    } catch (_) {
      _setError(_ExplanationError.generic);
    }
  }

  void _setError(_ExplanationError error) {
    if (!mounted) return;

    setState(() {
      _error = error;
      _isLoading = false;
      _jsonData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              color: Colors.amberAccent,
            ),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context).txtExplanation,
              style: const TextStyle(
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
          : _error != null
              ? _ErrorView(
                  error: _error!,
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
    required this.error,
    required this.onRetry,
  });

  final _ExplanationError error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final message = switch (error) {
      _ExplanationError.notFound => l10n.txtExplanationNotFound,
      _ExplanationError.loadFailed => l10n.txtExplanationLoadFailed,
      _ExplanationError.timeout => l10n.txtConnectionTimedOut,
      _ExplanationError.network => l10n.txtNetworkError,
      _ExplanationError.generic => l10n.txtExplanationGenericError,
    };

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
              l10n.txtExplanationLoadError,
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
              label: Text(l10n.txtTryAgain),
            ),
          ],
        ),
      ),
    );
  }
}

/// Distinct failure kinds for loading an explanation, resolved to localized
/// copy at display time in [_ErrorView].
enum _ExplanationError { notFound, loadFailed, timeout, network, generic }

class _UserFriendlyException implements Exception {
  final _ExplanationError kind;
  const _UserFriendlyException(this.kind);
}
