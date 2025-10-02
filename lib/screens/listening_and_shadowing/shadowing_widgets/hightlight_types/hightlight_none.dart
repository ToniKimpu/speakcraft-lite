import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

class HightlightNone extends StatelessWidget {
  const HightlightNone({
    super.key,
    required this.subtitleLine,
  });
  final SubtitleLine subtitleLine;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: List.generate(subtitleLine.words.length, (i) {
          final w = subtitleLine.words[i];
          // final current = position.inMilliseconds / 1000.0;

          // final double endBoundary = (i < subtitleLine.words.length - 1)
          //     ? subtitleLine.words[i + 1].start
          //     : w.end;

          // final isActive = current >= w.start && current < endBoundary;

          return TextSpan(
            text: "${w.word} ",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "ArchivoBlack Regular",
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}
