import 'package:flutter/material.dart';

import '../../../../config/pmp_text_styles.dart';
import '../../../../shared_widgets/practice_text_field.dart';

class SpokenPatternExample extends StatefulWidget {
  const SpokenPatternExample({super.key});

  @override
  State<SpokenPatternExample> createState() => _SpokenPatternExampleState();
}

class _SpokenPatternExampleState extends State<SpokenPatternExample> {
  final _userAnswerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint("_spokenPatternExample: spoken pattern example...");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burmese",
            style: PmpTextStyles.body2Regular.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            "ကျွန်တော် အပြင်သွားချင်တယ်။",
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "English",
            style: PmpTextStyles.body2Regular.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            "I want to go outside.",
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Your Answer",
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          PracticeTextField(
            controller: _userAnswerController,
            hintText: "",
            englishOnly: true,
            minLines: 2,
            maxHeight: 120,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Play",
                      style: PmpTextStyles.body2Semi.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ကစားသည်",
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Play",
                      style: PmpTextStyles.body2Semi.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ကစားသည်",
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Play",
                      style: PmpTextStyles.body2Semi.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ကစားသည်",
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Material(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF2C5364),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {});
              },
              child: SizedBox(
                height: 42,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Done",
                    style: PmpTextStyles.body1Semi.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
