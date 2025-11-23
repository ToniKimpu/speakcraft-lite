import 'package:flutter/material.dart';
import 'package:pmp_english/model/pattern_exercise/pattern_exercise.dart';

import '../models/added_word.dart';
import '../models/word_item.dart';

class SpokenPatternExerciseWidget extends StatefulWidget {
  const SpokenPatternExerciseWidget({
    super.key,
    required this.patternExercise,
    required this.availableWidth,
    required this.onAnswerChanged,
  });
  final PatternExercise patternExercise;
  final double availableWidth;
  final Function(String userAnswers) onAnswerChanged;

  @override
  State<SpokenPatternExerciseWidget> createState() =>
      _SpokenPatternExerciseWidgetState();
}

class _SpokenPatternExerciseWidgetState
    extends State<SpokenPatternExerciseWidget> {
  int _currentLine = 1;

  // Lines to hold words
  final List<String> line1 = [];
  final List<String> line2 = [];
  final List<String> line3 = [];

  // Cache measured widths
  final Map<String, double> _wordWidthCache = {};

  final TextStyle chipTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'ArchivoBlack Regular',
  );

  final double chipHorizontalPadding = 28.0;
  final double chipSpacing = 8.0;
  final double chipBorderWidth = 8.0;

  // Track added words for redo
  final List<AddedWord> addedStack = [];
  List<String> wordsWithQuotes = [];
  // WordChips managed by screen
  late List<WordItem> wordChips = [];

  @override
  void initState() {
    super.initState();
    final words = widget.patternExercise.englishText.trim().split(' ');
    wordChips = words.map((w) => WordItem(w)).toList();
    wordChips.shuffle();

    final text = widget.patternExercise.burmeseText.trim();
    final burmeseWords = text.split(' ');
    wordsWithQuotes = ['“', ...burmeseWords, '”'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  double _measureWordWidth(String word) {
    if (_wordWidthCache.containsKey(word)) return _wordWidthCache[word]!;

    final tp = TextPainter(
      text: TextSpan(text: word, style: chipTextStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    tp.layout();
    final total = tp.width + chipHorizontalPadding + chipBorderWidth;
    _wordWidthCache[word] = total;
    return total;
  }

  double _calculateLineWidth(List<String> words) {
    if (words.isEmpty) return 0.0;
    double width = 0.0;
    for (int i = 0; i < words.length; i++) {
      width += _measureWordWidth(words[i]);
      if (i != words.length - 1) width += chipSpacing;
    }
    return width;
  }

  // Try to add word to lines, returns true if added
  bool _addWordToAppropriateLine(String word, int wordChipIndex) {
    final w = _measureWordWidth(word);

    List<String> getLine(int lineNumber) {
      if (lineNumber == 1) return line1;
      if (lineNumber == 2) return line2;
      return line3;
    }

    // Try adding to current line first
    for (int i = 0; i < 3; i++) {
      final lineNumber = ((_currentLine + i - 1) % 3) + 1;
      final line = getLine(lineNumber);
      final lineWidth = _calculateLineWidth(line);

      if ((line.isEmpty && w <= widget.availableWidth) ||
          (lineWidth + chipSpacing + (line.isEmpty ? 0 : chipSpacing) + w <
              widget.availableWidth)) {
        setState(() {
          line.add(word);
          addedStack.add(AddedWord(word, lineNumber, wordChipIndex));
          wordChips[wordChipIndex].used = true;
          _currentLine = lineNumber; // move active line
          widget.onAnswerChanged(getFullTextFromAddedStack());
        });
        return true;
      }
    }
    debugPrint('_spokenPatternExerciseLogs: Could not fit word "$word"');
    // Could not fit anywhere
    return false;
  }

  // Redo last added word
  void _redoLastWord() {
    if (addedStack.isEmpty) return;
    final last = addedStack.removeLast();

    setState(() {
      // Remove from the correct line
      if (last.lineNumber == 1) line1.removeLast();
      if (last.lineNumber == 2) line2.removeLast();
      if (last.lineNumber == 3) line3.removeLast();

      // Restore WordChips
      wordChips[last.wordChipIndex].used = false;
      // Update active line to the line of the removed word
      _currentLine = last.lineNumber;
      widget.onAnswerChanged(getFullTextFromAddedStack());
    });
  }

  String getFullTextFromAddedStack() {
    return addedStack.map((e) => e.word).join(' ');
  }

  Widget _buildLine(List<String> words) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Container(
          padding: const EdgeInsets.only(bottom: 4),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Wrap(
              spacing: chipSpacing,
              runSpacing: 0,
              children: words.map((w) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black45,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.45),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    w,
                    style: chipTextStyle.copyWith(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: wordsWithQuotes.map((word) {
                return TextSpan(
                  text: "$word ",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: "MM Lyrics Bold",
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.deepOrangeAccent,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          _buildLine(line1),
          _buildLine(line2),
          _buildLine(line3),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: _redoLastWord,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: const Text(
                  "Redo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WordChips(
            wordChips: wordChips,
            onWordTap: _addWordToAppropriateLine,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class WordChips extends StatefulWidget {
  final List<WordItem> wordChips;
  final bool Function(String word, int wordChipIndex) onWordTap;

  const WordChips({
    super.key,
    required this.wordChips,
    required this.onWordTap,
  });

  @override
  State<WordChips> createState() => _WordChipsState();
}

class _WordChipsState extends State<WordChips> {
  WordItem? _pressedItem;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: widget.wordChips.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isPressed = _pressedItem == item;

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: item.used
              ? null
              : () async {
                  setState(() {
                    _pressedItem = item;
                  });
                  await Future.delayed(const Duration(milliseconds: 120));
                  setState(() {
                    _pressedItem = null;
                  });
                  // Attempt to add word, returns bool
                  widget.onWordTap(item.word, index);
                },
          child: AnimatedScale(
            scale: isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black45,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 4,
                ),
              ),
              child: Opacity(
                opacity: item.used ? 0.0 : 1.0,
                child: Text(
                  item.word,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
