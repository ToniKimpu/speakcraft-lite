import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';

import '../../model/subtitle_line.dart';

/// Static whole-line tint: when the playhead is inside this subtitle line,
/// the entire sentence gets a flat yellow background. No per-word animation.
class HighlightSentence extends StatelessWidget {
  final SubtitleLine subtitleLine;
  final SubtitleLine? nextSubtitleLine;
  final Duration position;
  final Function(Duration seekPosition) onSeek;

  const HighlightSentence({
    super.key,
    required this.subtitleLine,
    this.nextSubtitleLine,
    required this.position,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final current = position.inMilliseconds / 1000.0;
    double endBoundary = nextSubtitleLine?.start ?? subtitleLine.end;
    final isActive = current >= subtitleLine.start && current <= endBoundary;

    return GestureDetector(
      onTap: () => onSeek
          .call(Duration(milliseconds: (subtitleLine.start * 1000).toInt())),
      child: Text(
        subtitleLine.text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "ArchivoBlack Regular",
          color: colorScheme.onSurface,
          backgroundColor:
              isActive ? PmpColors.warning400.withValues(alpha: 0.4) : null,
        ),
      ),
    );
  }
}
