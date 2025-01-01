import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        focusNode: widget.focusNode,
        maxLines: 2,
        scrollPadding: const EdgeInsets.only(bottom: 120),
        onSubmitted: (value) => widget.onSubmitted?.call(),
        onChanged: (value) => widget.onChange?.call(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxHeight: 88,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            gapPadding: 1.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            gapPadding: 1.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            gapPadding: 1.0,
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
