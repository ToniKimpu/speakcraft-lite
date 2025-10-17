import 'package:flutter/material.dart';

class LineWithText extends StatefulWidget {
  const LineWithText({
    super.key,
    required this.englishText,
  });
  final String englishText;

  @override
  State<LineWithText> createState() => _LineWithTextState();
}

class _LineWithTextState extends State<LineWithText> {
  final _textKey = GlobalKey();
  double _textHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTextHeight();
    });
  }

  void _updateTextHeight() {
    final box = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && mounted) {
      setState(() {
        _textHeight = box.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 2,
          height: _textHeight,
          color: Colors.white.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.englishText,
            key: _textKey,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
