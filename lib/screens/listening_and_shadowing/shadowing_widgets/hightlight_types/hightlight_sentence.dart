import 'package:flutter/material.dart';

import '../../model/subtitle_line.dart';

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
    final current = position.inMilliseconds / 1000.0;
    double endBoundary = nextSubtitleLine?.start ?? subtitleLine.end;
    final isActive = current >= subtitleLine.start && current <= endBoundary;

    return GestureDetector(
      onTap: () => onSeek
          .call(Duration(milliseconds: (subtitleLine.start * 1000).toInt())),
      child: Text(
        subtitleLine.english,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontFamily: "ArchivoBlack Regular",
          color: Colors.white,
          backgroundColor:
              isActive ? Colors.yellow.withValues(alpha: 0.4) : null,
        ),
      ),
    );
  }
}
