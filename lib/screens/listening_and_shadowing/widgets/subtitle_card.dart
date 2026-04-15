import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/vocabulary_bottom_sheet.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_routes.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';

/// Renders a single subtitle line: the English sentence with inline tappable
/// vocabulary highlights, the optional Burmese translation, and the "View
/// Explanation" link. Built to sit inside [SubtitlePager].
class SubtitleCard extends StatefulWidget {
  const SubtitleCard({
    super.key,
    required this.youtubeController,
    required this.audioPlayer,
    required this.subtitle,
    required this.hasMMSub,
    this.vocabularyWords = const [],
    this.sourceYoutubeId,
  });

  final YoutubePlayerController youtubeController;
  final AudioPlayer audioPlayer;
  final Subtitle subtitle;
  final bool hasMMSub;
  final List<VocabularyWord> vocabularyWords;
  final String? sourceYoutubeId;

  @override
  State<SubtitleCard> createState() => _SubtitleCardState();
}

class _SubtitleCardState extends State<SubtitleCard> {
  // TapGestureRecognizers attached to TextSpans must be disposed manually.
  // Built fresh each build() and released here on widget tear-down.
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Recognizers from the previous build go out of scope as the RichText
    // tree is rebuilt — release them before allocating new ones.
    _disposeRecognizers();

    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInteractiveSentence(
            context,
            widget.subtitle.english,
            widget.vocabularyWords,
          ),
          const SizedBox(height: 6),
          if (widget.hasMMSub &&
              widget.subtitle.burmese != null &&
              widget.subtitle.burmese!.isNotEmpty)
            Text(
              widget.subtitle.burmese ?? "",
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 18,
                height: 1.8,
                fontFamily: "MM Lyrics Bold",
              ),
            ),
          const SizedBox(height: 8),
          if (widget.subtitle.explanationUrl.isNotEmpty) _buildExplanationButton(),
        ],
      ),
    );
  }

  Widget _buildExplanationButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _onExplanationTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.visibility_outlined,
                  size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).txtViewExplanation,
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.white,
                  fontFamily: "ArchivoBlack Regular",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onExplanationTap() {
    // Only pause YT when it's actively playing. Calling pause() during
    // buffering interrupts the buffer fetch and the iframe gets stuck in a
    // loading loop on return from the pushed route.
    if (widget.youtubeController.value.isPlaying) {
      widget.youtubeController.pause();
    }
    if (widget.audioPlayer.playing) {
      widget.audioPlayer.pause();
    }
    final sentenceExplanation = SentenceExplanation(
      id: 1,
      start: widget.subtitle.start.inSeconds.toDouble(),
      end: widget.subtitle.end.inSeconds.toDouble(),
      english: widget.subtitle.english,
      burmese: widget.subtitle.burmese ?? "",
      explanationUrl: widget.subtitle.explanationUrl,
    );
    Navigator.pushNamed(
      context,
      PmpRoutes.sentenceExplanationPage,
      arguments: {"sentence_explanation": sentenceExplanation},
    );
  }

  // ---------- Interactive sentence ----------

  TextStyle _englishStyle(BuildContext context) =>
      PmpTextStyles.body1Regular.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 20,
        height: 1.6,
        fontFamily: "ArchivoBlack Regular",
      );

  Widget _buildInteractiveSentence(
    BuildContext context,
    String english,
    List<VocabularyWord> vocabularyWords,
  ) {
    final baseStyle = _englishStyle(context);

    if (vocabularyWords.isEmpty) {
      return Text(english, style: baseStyle);
    }

    // Normalized lookup: lowercased + punctuation stripped at boundaries.
    final lookup = <String, VocabularyWord>{};
    for (final v in vocabularyWords) {
      final key = _normalize(v.word);
      if (key.isNotEmpty) {
        lookup[key] = v;
      }
    }

    if (lookup.isEmpty) {
      return Text(english, style: baseStyle);
    }

    final highlightStyle = baseStyle.copyWith(
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dotted,
      decorationColor: Colors.orange,
      decorationThickness: 1.5,
    );

    final spans = <InlineSpan>[];
    final tokenizer = RegExp(r'(\s+|\S+)');
    for (final match in tokenizer.allMatches(english)) {
      final token = match.group(0)!;
      if (token.trim().isEmpty) {
        spans.add(TextSpan(text: token));
        continue;
      }
      final normalized = _normalize(token);
      final entry = lookup[normalized];
      if (entry == null) {
        spans.add(TextSpan(text: token));
      } else {
        final recognizer = TapGestureRecognizer()
          ..onTap = () => _showVocabSheet(entry);
        _recognizers.add(recognizer);
        spans.add(TextSpan(
          text: token,
          style: highlightStyle,
          recognizer: recognizer,
        ));
      }
    }

    return Text.rich(TextSpan(style: baseStyle, children: spans));
  }

  String _normalize(String word) =>
      word.toLowerCase().replaceAll(RegExp(r'^[^\w]+|[^\w]+$'), '');

  void _showVocabSheet(VocabularyWord word) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VocabularyBottomSheet(
        word: word,
        sourceYoutubeId: widget.sourceYoutubeId,
        sourceSentence: widget.subtitle.english,
      ),
    );
  }
}
