import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/model/subtitle/subtitle.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_routes.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';

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
  });

  final YoutubePlayerController youtubeController;
  final AudioPlayer audioPlayer;
  final Subtitle subtitle;
  final bool hasMMSub;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle.english, style: _englishStyle(context)),
          const SizedBox(height: 6),
          if (hasMMSub &&
              subtitle.burmese != null &&
              subtitle.burmese!.isNotEmpty)
            Text(
              subtitle.burmese ?? "",
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 18,
                height: 1.8,
                fontFamily: "MM Lyrics Bold",
              ),
            ),
          const SizedBox(height: 8),
          if (subtitle.explanationUrl.isNotEmpty)
            _buildExplanationButton(context),
        ],
      ),
    );
  }

  Widget _buildExplanationButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _onExplanationTap(context),
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
      id: 1,
      start: subtitle.start.inSeconds.toDouble(),
      end: subtitle.end.inSeconds.toDouble(),
      english: subtitle.english,
      burmese: subtitle.burmese ?? "",
      explanationUrl: subtitle.explanationUrl,
    );
    Navigator.pushNamed(
      context,
      PmpRoutes.sentenceExplanationPage,
      arguments: {"sentence_explanation": sentenceExplanation},
    );
  }

  TextStyle _englishStyle(BuildContext context) =>
      PmpTextStyles.body1Regular.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 20,
        height: 1.6,
        fontFamily: "ArchivoBlack Regular",
      );
}
