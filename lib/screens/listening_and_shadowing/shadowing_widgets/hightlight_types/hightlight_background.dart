import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

class HightlightBackground extends StatelessWidget {
  const HightlightBackground({
    super.key,
    required this.subtitleLine,
    this.nextSubtitleLine,
    required this.position,
    required this.onSeek,
  });
  final SubtitleLine subtitleLine;
  final SubtitleLine? nextSubtitleLine;
  final Duration position;
  final Function(Duration seekPosition) onSeek;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: List.generate(subtitleLine.words.length, (i) {
          final w = subtitleLine.words[i];
          final current = position.inMilliseconds / 1000.0;
          // Determine end boundary for the current word
          double endBoundary;
          if (i < subtitleLine.words.length - 1) {
            // If not the last word in the line, next word's start
            endBoundary = subtitleLine.words[i + 1].start;
          } else {
            // Last word: use next line's first word start if exists, else word's own end
            endBoundary = nextSubtitleLine?.words.first.start ?? w.end;
          }

          final isActive = current >= w.start && current < endBoundary;

          return WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () =>
                  onSeek.call(Duration(milliseconds: (w.start * 1000).toInt())),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  w.word,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: "ArchivoBlack Regular",
                    color: Colors.white, // keep text always white
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
