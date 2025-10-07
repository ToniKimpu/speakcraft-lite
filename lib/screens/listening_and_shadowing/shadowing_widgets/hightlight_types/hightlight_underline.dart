import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

class HightlightUnderline extends StatelessWidget {
  const HightlightUnderline({
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

          return TextSpan(
            text: "${w.word} ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "ArchivoBlack Regular",
              color: Colors.white,
              decoration:
                  isActive ? TextDecoration.underline : TextDecoration.none,
              decorationColor: Colors.amber,
              decorationThickness: 2, // make underline a bit bolder
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onSeek.call(Duration(milliseconds: (w.start * 1000).toInt()));
              },
          );
        }),
      ),
    );
  }
}
