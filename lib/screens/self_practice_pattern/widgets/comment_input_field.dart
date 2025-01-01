import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField({
    super.key,
    required ValueNotifier<double> textFieldPositionNotifier,
    required TextEditingController commentController,
    required ValueNotifier<bool> commentNotifier,
    required this.addComment,
  })  : _textFieldPositionNotifier = textFieldPositionNotifier,
        _commentController = commentController,
        _commentNotifier = commentNotifier;

  final ValueNotifier<double> _textFieldPositionNotifier;
  final TextEditingController _commentController;
  final ValueNotifier<bool> _commentNotifier;

  final Function(String comment) addComment;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: _textFieldPositionNotifier,
      builder: (context, position, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: position,
          left: 10,
          right: 10,
          child: child!,
        );
      },
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              maxLines: null, // Allows multiple lines
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: PmpColors.primary400, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: PmpColors.primary400, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: PmpColors.primary400, width: 2),
                ),
                hintText: 'Write here....',
                hintStyle:
                    PmpTextStyles.body2Medium.copyWith(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _commentNotifier,
            builder: (context, isCommenting, child) {
              if (isCommenting) {
                return const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                );
              }
              return child!;
            },
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9999),
              child: InkWell(
                onTap: () {
                  if (_commentController.text.trim().isEmpty) return;
                  FocusManager.instance.primaryFocus?.unfocus();
                  addComment(_commentController.text.trim());
                },
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Icon(
                    Icons.send,
                    color: PmpColors.primary400,
                    size: 24,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
