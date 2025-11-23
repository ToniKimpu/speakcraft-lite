import 'package:flutter/material.dart';

class WordChips extends StatefulWidget {
  final String englishText;
  final TextEditingController controller;
  final VoidCallback onTap;
  // now a set of indices (original positions) instead of strings
  final Set<int> usedWordIndices;
  // markWordUsed receives (word, originalIndex)
  final void Function(String word, int index) markWordUsed;

  const WordChips({
    super.key,
    required this.englishText,
    required this.controller,
    required this.onTap,
    required this.usedWordIndices,
    required this.markWordUsed,
  });

  @override
  State<WordChips> createState() => _WordChipsState();
}

class _WordChipsState extends State<WordChips> {
  String? _pressedWord;

  // pair of (originalIndex, word)
  late List<MapEntry<int, String>> shuffledPairs;

  @override
  void initState() {
    super.initState();
    final words = widget.englishText.trim().split(' ');
    // keep original indices so duplicates are distinct
    final pairs = words.asMap().entries.toList(); // MapEntry<int, String>
    shuffledPairs = List<MapEntry<int, String>>.from(pairs);
    shuffledPairs.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: shuffledPairs.map((pair) {
        final originalIndex = pair.key;
        final word = pair.value;
        final isPressed = _pressedWord == '${word}_$originalIndex';
        final isUsed = widget.usedWordIndices.contains(originalIndex);

        return InkWell(
          onTap: isUsed
              ? null
              : () async {
                  setState(() {
                    _pressedWord = '${word}_$originalIndex';
                  });

                  await Future.delayed(const Duration(milliseconds: 120));
                  setState(() {
                    _pressedWord = null;
                  });

                  // notify parent with the original index (so duplicates are distinct)
                  widget.markWordUsed(word, originalIndex);

                  final current = widget.controller.text.trim();
                  widget.controller.text =
                      current.isEmpty ? word : "$current $word";

                  widget.onTap.call();
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
                opacity: isUsed ? 0.0 : 1.0,
                child: Text(
                  word,
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
