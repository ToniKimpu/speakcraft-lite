import 'subtitle_word.dart';

class SubtitleLine {
  final String id;
  final double start;
  final double end;
  final String text;
  final String? burmese;
  final List<SubtitleWord> words;

  SubtitleLine({
    required this.id,
    required this.start,
    required this.end,
    required this.text,
    this.burmese,
    required this.words,
  });

  factory SubtitleLine.fromJson(Map<String, dynamic> json) {
    return SubtitleLine(
      id: json['id'] as String,
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String,
      burmese: json['burmese'] as String?,
      words: json['words'] != null
          ? (json['words'] as List)
              .map((w) => SubtitleWord.fromJson(w))
              .toList()
          : [],
    );
  }
}
