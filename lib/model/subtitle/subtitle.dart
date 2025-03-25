class Subtitle {
  final int id; // Unique identifier
  final Duration start;
  final Duration end;
  final String text;
  final String? burmese;
  final double? widgetHeight;
  final double? scrollPosition;

  Subtitle({
    required this.id,
    required this.start,
    required this.end,
    required this.text,
    this.burmese,
    this.widgetHeight,
    this.scrollPosition,
  });

  /// Factory constructor for an empty subtitle
  static final Subtitle empty = Subtitle(
    id: -1, // -1 to indicate an empty subtitle
    start: Duration.zero,
    end: Duration.zero,
    text: '',
    widgetHeight: 0,
    scrollPosition: 0,
  );

  /// Checks if the subtitle is empty
  bool get isEmpty =>
      id == -1 ||
      (start == Duration.zero && end == Duration.zero && text.isEmpty);

  /// Checks if the subtitle is not empty
  bool get isNotEmpty => !isEmpty;

  Subtitle copyWith({
    int? id,
    Duration? start,
    Duration? end,
    String? text,
    String? burmese,
    double? widgetHeight,
    double? scrollPosition,
    double? englishScrollPosition,
  }) {
    return Subtitle(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      text: text ?? this.text,
      burmese: burmese ?? this.burmese,
      widgetHeight: widgetHeight ?? this.widgetHeight,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }
}
