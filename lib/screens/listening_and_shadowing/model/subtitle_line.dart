import 'subtitle_word.dart';

class SubtitleLine {
  final double start;
  final double end;
  final String english;
  final String? burmese;
  final List<SubtitleWord> words;

  SubtitleLine({
    required this.start,
    required this.end,
    required this.english,
    this.burmese,
    required this.words,
  });

  factory SubtitleLine.fromJson(Map<String, dynamic> json) {
    return SubtitleLine(
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      english: json['english'] as String,
      burmese: json['burmese'] as String?,
      words: json['words'] != null
          ? (json['words'] as List)
              .map((w) => SubtitleWord.fromJson(w))
              .toList()
          : [],
    );
  }
}
