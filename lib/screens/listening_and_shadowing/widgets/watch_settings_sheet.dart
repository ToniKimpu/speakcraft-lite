import 'package:flutter/material.dart';

import '../../../config/pmp_text_styles.dart';

/// Bottom sheet of Watch-screen subtitle settings: show Burmese, word-highlight
/// (karaoke), and playback speed. Holds a local mirror so the controls update
/// instantly; each change is pushed back to the page via callbacks (which apply
/// + persist).
class WatchSettingsSheet extends StatefulWidget {
  const WatchSettingsSheet({
    super.key,
    required this.showMM,
    required this.mmAvailable,
    required this.karaoke,
    required this.karaokeAvailable,
    required this.speed,
    required this.onShowMM,
    required this.onKaraoke,
    required this.onSpeed,
  });

  final bool showMM;
  final bool mmAvailable;
  final bool karaoke;
  final bool karaokeAvailable;
  final double speed;
  final ValueChanged<bool> onShowMM;
  final ValueChanged<bool> onKaraoke;
  final ValueChanged<double> onSpeed;

  static const speeds = [0.5, 0.75, 1.0, 1.25, 1.5];

  @override
  State<WatchSettingsSheet> createState() => _WatchSettingsSheetState();
}

class _WatchSettingsSheetState extends State<WatchSettingsSheet> {
  late bool _showMM = widget.showMM;
  late bool _karaoke = widget.karaoke;
  late double _speed = widget.speed;

  static String _fmtRate(double r) =>
      '${r == r.roundToDouble() ? r.toStringAsFixed(0) : r}×';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6, left: 4),
              child: Text('Subtitle settings',
                  style: PmpTextStyles.title1SemiBold
                      .copyWith(color: cs.onSurface)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show Burmese'),
              value: _showMM,
              onChanged: widget.mmAvailable
                  ? (v) {
                      setState(() => _showMM = v);
                      widget.onShowMM(v);
                    }
                  : null,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Word highlight'),
              subtitle: Text(
                widget.karaokeAvailable
                    ? 'Highlights each word as it\'s spoken'
                    : 'Not available for this video',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant),
              ),
              value: _karaoke && widget.karaokeAvailable,
              onChanged: widget.karaokeAvailable
                  ? (v) {
                      setState(() => _karaoke = v);
                      widget.onKaraoke(v);
                    }
                  : null,
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text('Speed',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
            ),
            Wrap(
              spacing: 8,
              children: [
                for (final s in WatchSettingsSheet.speeds)
                  ChoiceChip(
                    label: Text(_fmtRate(s)),
                    selected: _speed == s,
                    onSelected: (_) {
                      setState(() => _speed = s);
                      widget.onSpeed(s);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
