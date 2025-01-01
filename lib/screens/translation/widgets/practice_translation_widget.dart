import 'package:flutter/material.dart';
import 'package:pmp_english/model/translation/translation.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../shared_widgets/practice_checkbox.dart';
import '../../../shared_widgets/practice_text_field.dart';
import '../../../shared_widgets/vocabulary_notifier_widget.dart';

class PracticeTranslationWidget extends StatefulWidget {
  const PracticeTranslationWidget({
    super.key,
    this.focusNode,
    required this.translation,
    required this.onUserInput,
  });

  final FocusNode? focusNode;
  final Translation translation;
  final Function(String value) onUserInput;

  @override
  State<PracticeTranslationWidget> createState() =>
      _PracticeTranslationWidgetState();
}

class _PracticeTranslationWidgetState extends State<PracticeTranslationWidget> {
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _showVocabularyNotifier;
  late final ValueNotifier<bool> _wordNotifier;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _showVocabularyNotifier = ValueNotifier<bool>(false);
    _wordNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _showVocabularyNotifier.dispose();
    _wordNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burmese",
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            widget.translation.burmeseText,
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Your Answer:',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          PracticeTextField(
            englishOnly: true,
            focusNode: widget.focusNode,
            controller: _controller,
            onChange: (value) => widget.onUserInput(value),
          ),
          const SizedBox(
            height: 12,
          ),
          if (widget.translation.words != null &&
              widget.translation.words!.isNotEmpty)
            PracticeCheckbox(
              practiceNotifier: _wordNotifier,
              label: 'Words',
              isWrods: true,
              onBackward: () {
                String currentText = _controller.text.trim();
                List<String> words = currentText.split(' ');
                if (words.isNotEmpty) {
                  words.removeLast();
                  _controller.text = '${words.join(' ')} ';
                  widget.onUserInput(_controller.text);
                }
              },
            ),
          if (widget.translation.words != null &&
              widget.translation.words!.isNotEmpty)
            PracticeWordWidget(
              widget: widget,
              controller: _controller,
              showWordList: _wordNotifier,
            ),
          if (widget.translation.vocabularies != null &&
              widget.translation.vocabularies!.isNotEmpty)
            PracticeCheckbox(
              practiceNotifier: _showVocabularyNotifier,
              label: 'Vocabulary',
            ),
          if (widget.translation.vocabularies != null &&
              widget.translation.vocabularies!.isNotEmpty)
            VocabularyNotifierWidget(
              showVocabularyNotifier: _showVocabularyNotifier,
              vocabularies: widget.translation.vocabularies!,
            ),
        ],
      ),
    );
  }
}

class PracticeWordWidget extends StatelessWidget {
  const PracticeWordWidget({
    super.key,
    required this.widget,
    required TextEditingController controller,
    required this.showWordList,
  }) : _controller = controller;

  final PracticeTranslationWidget widget;
  final TextEditingController _controller;
  final ValueNotifier<bool> showWordList;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showWordList,
      builder: (context, showWordList, child) {
        return Offstage(
          offstage: !showWordList,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Wrap(
          spacing: 12,
          runSpacing: 8,
          children:
              (widget.translation.words!.split(' ')..shuffle()).map((text) {
            return Material(
              color: PmpColors.primary400,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (_controller.text.isNotEmpty &&
                      !_controller.text.endsWith(' ')) {
                    _controller.text += ' ';
                  }
                  _controller.text += text;
                  widget.onUserInput(_controller.text);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                  ),
                  child: Text(
                    text,
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
