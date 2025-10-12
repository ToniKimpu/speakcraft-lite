import 'package:flutter/material.dart';

class SentencePracticeWidgetTwo extends StatefulWidget {
  const SentencePracticeWidgetTwo({
    super.key,
  });

  @override
  State<SentencePracticeWidgetTwo> createState() =>
      _SentencePracticeWidgetTwoState();
}

class _SentencePracticeWidgetTwoState extends State<SentencePracticeWidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          const Text(
            "What does the sentence mean?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              height: 1.4,
              fontFamily: "ArchivoBlack Regular",
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          // 🟢 Option buttons
          _buildOption("He left the country."),
          const SizedBox(height: 12),
          _buildOption("He gave up on the country."),
          const SizedBox(height: 12),
          _buildOption("He is now working hard for the nation."),
          const SizedBox(height: 12),
          _buildOption("He is fighting against the country."),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildOption(String text) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF203A43),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
