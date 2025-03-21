import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class PracticeTextField extends StatefulWidget {
  const PracticeTextField({
    super.key,
    this.focusNode,
    this.onSubmitted,
    this.englishOnly = false,
    required this.controller,
    this.onChange,
  });
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;
  final bool englishOnly;
  final TextEditingController controller;
  final Function(String value)? onChange;

  @override
  State<PracticeTextField> createState() => _PracticeTextFieldState();
}

class _PracticeTextFieldState extends State<PracticeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        focusNode: widget.focusNode,
        maxLines: 2,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        scrollPadding: const EdgeInsets.only(bottom: 120),
        onSubmitted: (value) => widget.onSubmitted?.call(),
        onChanged: (value) => widget.onChange?.call(value),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.1),
          contentPadding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(
            maxHeight: 88,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5), // Subtle border
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            gapPadding: 1.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            gapPadding: 1.0,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent, // Highlight color when focused
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            gapPadding: 1.0,
          ),
          hintText: "Enter your answer...",
          hintStyle: PmpTextStyles.body2Semi.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        inputFormatters: !widget.englishOnly
            ? null
            : <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))
              ],
      ),
    );
  }
}
