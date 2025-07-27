import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../shared_widgets/practice_text_field.dart';

class AiPracticeScreen extends StatefulWidget {
  const AiPracticeScreen({super.key});

  @override
  State<AiPracticeScreen> createState() => _AiPracticeScreenState();
}

class _AiPracticeScreenState extends State<AiPracticeScreen> {
  late final TextEditingController _sentenceController;
  @override
  initState() {
    super.initState();
    _sentenceController = TextEditingController();
  }

  @override
  void dispose() {
    _sentenceController.dispose();
    super.dispose();
  }

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: PmpColors.darkSurface,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        title: const Text('Practice with AI'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              color: const Color(0xFF1C2C3C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Write your own sentence here",
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: PmpColors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PracticeTextField(
                      controller: _sentenceController,
                      hintText: "Enter your sentence here",
                      englishOnly: true,
                      onChange: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
