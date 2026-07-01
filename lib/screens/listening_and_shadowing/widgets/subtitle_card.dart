import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/model/subtitle/subtitle.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_word.dart';
import 'package:speakcraft/screens/listening_and_shadowing/shadowing_widgets/highlight_types/highlight_background.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_routes.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../shared_widgets/premium_gate.dart';

/// Renders a single subtitle line: the English sentence, the optional Burmese
/// translation, and the "View Explanation" link. Built to sit inside
/// [SubtitlePager].
class SubtitleCard extends StatelessWidget {
  const SubtitleCard({
    super.key,
    required this.youtubeController,
    required this.audioPlayer,
    required this.subtitle,
    required this.hasMMSub,
    this.karaokeEnabled = false,
    this.positionListenable,
    this.words = const [],
    this.importId = '',
    this.explanationLocked = false,
  });

  final YoutubePlayerController youtubeController;
  final AudioPlayer audioPlayer;
  final Subtitle subtitle;
  final bool hasMMSub;

  /// Karaoke word-highlight: when enabled and we have [words] + a
  /// [positionListenable], the English line sweeps a per-word highlight in time
  /// with the video (reusing the shadowing painter).
  final bool karaokeEnabled;
  final ValueListenable<Duration>? positionListenable;
  final List<SubtitleWord> words;

  /// Non-empty for imports — makes "View explanation" appear even before the
  /// explanation is generated (premium taps generate it on demand).
  final String importId;

  /// When true, "View explanation" is gated behind Premium (non-free video).
  final bool explanationLocked;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEnglish(context),
          const SizedBox(height: 12),
          if (hasMMSub &&
              subtitle.burmese != null &&
              subtitle.burmese!.isNotEmpty)
            Text(
              subtitle.burmese!,
              textAlign: TextAlign.start,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 17,
                height: 1.7,
                fontFamily: 'Noto Sans Myanmar',
                fontWeight: FontWeight.w400,
              ),
            ),
          const SizedBox(height: 12),
          if (subtitle.explanationUrl.isNotEmpty || importId.isNotEmpty)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: _buildExplanationButton(context),
            ),
        ],
      ),
    );
  }

  /// The English line — karaoke sweep when enabled (and we have word timings),
  /// otherwise the plain styled sentence.
  Widget _buildEnglish(BuildContext context) {
    final listenable = positionListenable;
    if (!karaokeEnabled || words.isEmpty || listenable == null) {
      return Text(
        subtitle.english,
        textAlign: TextAlign.start,
        style: _englishStyle(context),
      );
    }
    final line = SubtitleLine(
      id: subtitle.id?.toString() ?? '',
      start: subtitle.start.inMilliseconds / 1000.0,
      end: subtitle.end.inMilliseconds / 1000.0,
      text: subtitle.english,
      words: words,
    );
    return RepaintBoundary(
      child: ValueListenableBuilder<Duration>(
        valueListenable: listenable,
        builder: (_, position, __) => HighlightBackground(
          subtitleLine: line,
          position: position,
          onSeek: youtubeController.seekTo,
        ),
      ),
    );
  }

  Widget _buildExplanationButton(BuildContext context) {
    return Material(
      color: PmpColors.accentOrange,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => explanationLocked
            ? showPremiumSheet(context,
                featureName: AppLocalizations.of(context).txtViewExplanation)
            : _onExplanationTap(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                explanationLocked
                    ? Icons.lock_outline
                    : Icons.lightbulb_outline,
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).txtViewExplanation,
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onExplanationTap(BuildContext context) {
    // Only pause YT when it's actively playing. Calling pause() during
    // buffering interrupts the buffer fetch and the iframe gets stuck in a
    // loading loop on return from the pushed route.
    if (youtubeController.value.isPlaying) {
      youtubeController.pause();
    }
    if (audioPlayer.playing) {
      audioPlayer.pause();
    }
    final sentenceExplanation = SentenceExplanation(
      // For imports this must be the real line id so on-demand generation knows
      // which sentence to explain.
      id: subtitle.id ?? 0,
      start: subtitle.start.inSeconds.toDouble(),
      end: subtitle.end.inSeconds.toDouble(),
      english: subtitle.english,
      burmese: subtitle.burmese ?? "",
      explanationUrl: subtitle.explanationUrl,
    );
    Navigator.pushNamed(
      context,
      PmpRoutes.sentenceExplanationPage,
      arguments: {
        "sentence_explanation": sentenceExplanation,
        "import_id": importId,
      },
    );
  }

  TextStyle _englishStyle(BuildContext context) => GoogleFonts.lora(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: -0.1,
      );
}
