import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_word.dart';

/// Karaoke-style progressive highlight: a continuous fill sweeps left-to-right
/// across the whole sentence (including spaces between words), per-word timing,
/// flowing onto the next visual row when the line wraps.
class HighlightBackground extends StatelessWidget {
  const HighlightBackground({
    super.key,
    required this.subtitleLine,
    this.nextSubtitleLine,
    required this.position,
    required this.onSeek,
  });

  final SubtitleLine subtitleLine;
  final SubtitleLine? nextSubtitleLine;
  final Duration position;
  final Function(Duration seekPosition) onSeek;

  static const _radius = Radius.circular(4);
  static const _verticalPad = 0.0;

  TextStyle _textStyle(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamily: "ArchivoBlack Regular",
        color: Theme.of(context).colorScheme.onSurface,
      );

  @override
  Widget build(BuildContext context) {
    final textStyle = _textStyle(context);
    if (subtitleLine.words.isEmpty) {
      return Text(subtitleLine.text, style: textStyle);
    }

    return GestureDetector(
      onTap: () {
        onSeek(
          Duration(milliseconds: (subtitleLine.start * 1000).toInt()),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fullText = subtitleLine.words.map((w) => w.word).join(' ');
          final measurer = TextPainter(
            text: TextSpan(text: fullText, style: textStyle),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);

          return CustomPaint(
            size: Size(
              constraints.maxWidth,
              measurer.height + _verticalPad * 2,
            ),
            painter: _KaraokePainter(
              words: subtitleLine.words,
              nextLineFirstWordStart: (nextSubtitleLine != null &&
                      nextSubtitleLine!.words.isNotEmpty)
                  ? nextSubtitleLine!.words.first.start
                  : null,
              currentSeconds: position.inMilliseconds / 1000.0,
              textStyle: textStyle,
              fillColor: PmpColors.warning400.withValues(alpha: 0.55),
              radius: _radius,
              verticalPad: _verticalPad,
            ),
          );
        },
      ),
    );
  }
}

class _KaraokePainter extends CustomPainter {
  _KaraokePainter({
    required this.words,
    required this.nextLineFirstWordStart,
    required this.currentSeconds,
    required this.textStyle,
    required this.fillColor,
    required this.radius,
    required this.verticalPad,
  });

  final List<SubtitleWord> words;
  final double? nextLineFirstWordStart;
  final double currentSeconds;
  final TextStyle textStyle;
  final Color fillColor;
  final Radius radius;
  final double verticalPad;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Build joined text + per-word character ranges.
    final buffer = StringBuffer();
    final ranges = <List<int>>[];
    for (int i = 0; i < words.length; i++) {
      if (i > 0) buffer.write(' ');
      final s = buffer.length;
      buffer.write(words[i].word);
      ranges.add([s, buffer.length]);
    }
    final fullText = buffer.toString();

    // 2. Lay out once.
    final tp = TextPainter(
      text: TextSpan(text: fullText, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width);

    // 3. Row rects: one box per visual row of the wrapped text.
    //    Use includeLineSpacingMiddle so adjacent row boxes tile exactly
    //    (row N bottom == row N+1 top) — no pixel overlap at row junctions
    //    which would otherwise alpha-compound to a darker band, and no gap
    //    which would look like a stripe through the middle of a sentence.
    final rowBoxes = tp.getBoxesForSelection(
      TextSelection(baseOffset: 0, extentOffset: fullText.length),
      boxHeightStyle: ui.BoxHeightStyle.includeLineSpacingMiddle,
    );

    if (rowBoxes.isEmpty) {
      canvas.save();
      canvas.translate(0, verticalPad);
      tp.paint(canvas, Offset.zero);
      canvas.restore();
      return;
    }

    // 4. First-box for each word (used to find each word's row + left x).
    final wordBoxes = <Rect>[];
    for (final range in ranges) {
      final bs = tp.getBoxesForSelection(
        TextSelection(baseOffset: range[0], extentOffset: range[1]),
      );
      wordBoxes.add(bs.isNotEmpty ? bs.first.toRect() : Rect.zero);
    }

    int rowOfWord(int i) {
      final box = wordBoxes[i];
      final yMid = (box.top + box.bottom) / 2;
      for (int r = 0; r < rowBoxes.length; r++) {
        if (yMid >= rowBoxes[r].top && yMid <= rowBoxes[r].bottom) return r;
      }
      return 0;
    }

    // 5. Walk words to find the cursor (active row + fill-right-x).
    //    activeRowIndex == -1 means the line hasn't started yet (no fill).
    int activeRowIndex = -1;
    double fillRightX = 0;
    bool allPast = true;

    for (int i = 0; i < words.length; i++) {
      final w = words[i];
      final double endBoundary = (i < words.length - 1)
          ? words[i + 1].start
          : (nextLineFirstWordStart ?? w.end);

      if (currentSeconds >= endBoundary) {
        // Fully past — keep scanning to find an active or future word.
        continue;
      }

      allPast = false;

      if (currentSeconds >= w.start) {
        // Active word — interpolate cursor through this word and into the
        // following space (so the fill sweeps continuously across spaces).
        final wordBox = wordBoxes[i];
        final wordRow = rowOfWord(i);
        final duration = endBoundary - w.start;
        final t = duration > 0
            ? ((currentSeconds - w.start) / duration).clamp(0.0, 1.0)
            : 1.0;

        // Endpoint the cursor sweeps toward during this word's window:
        // - same-row next word → its left edge (sweeps through the space)
        // - different-row next word → end of current row (completes the row)
        // - no next word → end of current row
        double endpointX;
        if (i + 1 < words.length) {
          final nextRow = rowOfWord(i + 1);
          if (nextRow == wordRow) {
            endpointX = wordBoxes[i + 1].left;
          } else {
            endpointX = rowBoxes[wordRow].right;
          }
        } else {
          endpointX = rowBoxes[wordRow].right;
        }

        activeRowIndex = wordRow;
        fillRightX = wordBox.left + (endpointX - wordBox.left) * t;
      }
      // Else: future word with no earlier active — stop here, leave activeRowIndex = -1.
      break;
    }

    if (allPast && words.isNotEmpty) {
      // Past the entire line — fill every row fully so completed sentences
      // stay highlighted in the scrolling list.
      activeRowIndex = rowBoxes.length - 1;
      fillRightX = rowBoxes.last.right;
    }

    // 6. Paint.
    canvas.save();
    canvas.translate(0, verticalPad);

    final fillPaint = Paint()..color = fillColor;

    // Fully fill all rows above the active row.
    for (int r = 0; r < activeRowIndex; r++) {
      final row = rowBoxes[r];
      _drawFill(canvas, fillPaint, row.left, row.top, row.right, row.bottom);
    }

    // Partial fill on the active row.
    if (activeRowIndex >= 0 && activeRowIndex < rowBoxes.length) {
      final row = rowBoxes[activeRowIndex];
      if (fillRightX > row.left) {
        _drawFill(canvas, fillPaint, row.left, row.top, fillRightX, row.bottom);
      }
    }

    tp.paint(canvas, Offset.zero);
    canvas.restore();
  }

  void _drawFill(
    Canvas canvas,
    Paint paint,
    double left,
    double top,
    double right,
    double bottom,
  ) {
    if (right <= left) return;
    final rect = Rect.fromLTRB(
      left,
      top - verticalPad,
      right,
      bottom + verticalPad,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
  }

  @override
  bool shouldRepaint(covariant _KaraokePainter oldDelegate) {
    return oldDelegate.currentSeconds != currentSeconds ||
        oldDelegate.words != words ||
        oldDelegate.nextLineFirstWordStart != nextLineFirstWordStart;
  }
}
