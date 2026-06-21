import 'package:flutter/material.dart';
import 'package:speakcraft/services/tts_service.dart';

/// A small speaker button that reads [text] aloud via the device TTS — used next
/// to AI corrections / suggestions so a learner can hear the correct English.
/// Renders nothing for empty text.
class PronounceButton extends StatelessWidget {
  const PronounceButton({
    super.key,
    required this.text,
    this.color,
    this.size = 18,
  });

  final String text;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (text.trim().isEmpty) return const SizedBox.shrink();
    final c = color ?? Theme.of(context).colorScheme.primary;
    return IconButton(
      icon: Icon(Icons.volume_up_outlined, size: size, color: c),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      splashRadius: 18,
      tooltip: 'Listen',
      onPressed: () => TtsService.instance.speak(text),
    );
  }
}
