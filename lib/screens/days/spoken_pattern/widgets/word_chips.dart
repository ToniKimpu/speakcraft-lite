import 'package:flutter/material.dart';

class WordChips extends StatefulWidget {
  final String englishText;
  final TextEditingController controller;
  final VoidCallback onTap;
  final Set<String> usedWords; // 👈 passed from parent
  final void Function(String word) markWordUsed; // 👈 callback to parent

  const WordChips({
    super.key,
    required this.englishText,
    required this.controller,
    required this.onTap,
    required this.usedWords,
    required this.markWordUsed,
  });

  @override
  State<WordChips> createState() => _WordChipsState();
}

class _WordChipsState extends State<WordChips> {
  String? _pressedWord; // 👈 keep track of which chip is pressed
  List<String> shuffledWords = [];
  @override
  void initState() {
    super.initState();
    final words = widget.englishText.trim().split(' ');
    shuffledWords = List<String>.from(words); // copy the list
    shuffledWords.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: shuffledWords.map((word) {
        final isPressed = _pressedWord == word;
        final isUsed = widget.usedWords.contains(word); // 👈 hide if used

        return InkWell(
          onTap: isUsed
              ? null
              : () async {
                  setState(() {
                    _pressedWord = word;
                  });

                  await Future.delayed(const Duration(milliseconds: 120));
                  setState(() {
                    _pressedWord = null;
                  });

                  widget.markWordUsed(word);
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
                // offstage: isUsed,
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
