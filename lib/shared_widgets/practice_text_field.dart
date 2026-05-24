import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';

class PracticeTextField extends StatefulWidget {
  const PracticeTextField({
    super.key,
    this.focusNode,
    this.onSubmitted,
    this.hintText,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.maxHeight,
    this.englishOnly = false,
    required this.controller,
    this.onChange,
    this.textStyle,
    this.readOnly = false,
  });
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;
  final bool englishOnly;
  final TextEditingController controller;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? textStyle;
  final bool readOnly;

  final double? maxHeight;
  final Function(String value)? onChange;

  @override
  State<PracticeTextField> createState() => _PracticeTextFieldState();
}

class _PracticeTextFieldState extends State<PracticeTextField> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        style: widget.textStyle ??
            TextStyle(color: colorScheme.onSurface),
        cursorColor: colorScheme.onSurface,
        scrollPadding: const EdgeInsets.only(bottom: 120),
        onSubmitted: (value) => widget.onSubmitted?.call(),
        onChanged: (value) => widget.onChange?.call(value),
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          if (maxLength == null) {
            return null;
          }
          return Text(
            "$currentLength/$maxLength",
            style: PmpTextStyles.labelSemi.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          );
        },
        decoration: InputDecoration(
          fillColor: colorScheme.surfaceContainerHighest,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gapPadding: 1.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gapPadding: 1.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.onSurface),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gapPadding: 1.0,
          ),
          hintText: widget.hintText ?? "Enter your answer...",
          hintStyle: PmpTextStyles.body2Semi.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        inputFormatters: !widget.englishOnly
            ? null
            : <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[\x00-\x7F]'))
              ],
      ),
    );
  }
}
