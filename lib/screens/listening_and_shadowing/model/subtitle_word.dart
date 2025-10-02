class SubtitleWord {
  final String word;
  final double start;
  final double end;
  final double score;

  SubtitleWord({
    required this.word,
    required this.start,
    required this.end,
    required this.score,
  });

  factory SubtitleWord.fromJson(Map<String, dynamic> json) {
    return SubtitleWord(
      word: json['word'],
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      score: (json['score'] as num).toDouble(),
    );
  }
}
