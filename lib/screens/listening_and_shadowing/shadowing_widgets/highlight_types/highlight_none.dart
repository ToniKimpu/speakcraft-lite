import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

/// No highlight: just renders the line as plain white text.
class HighlightNone extends StatelessWidget {
  const HighlightNone({
    super.key,
    required this.subtitleLine,
  });
  final SubtitleLine subtitleLine;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return RichText(
      text: TextSpan(
        children: List.generate(subtitleLine.words.length, (i) {
          final w = subtitleLine.words[i];
          return TextSpan(
            text: "${w.word} ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "ArchivoBlack Regular",
              color: onSurface,
            ),
          );
        }),
      ),
    );
  }
}
