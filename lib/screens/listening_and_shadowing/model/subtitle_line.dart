import 'subtitle_word.dart';

class SubtitleLine {
  final double start;
  final double end;
  final String text;
  final List<SubtitleWord> words;

  SubtitleLine({
    required this.start,
    required this.end,
    required this.text,
    required this.words,
  });

  factory SubtitleLine.fromJson(Map<String, dynamic> json) {
    return SubtitleLine(
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'],
      words:
          (json['words'] as List).map((w) => SubtitleWord.fromJson(w)).toList(),
    );
  }
}
