import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_version.dart';
import '../../repositories/speak_your_mind/sym_session_repository.dart';
import '../../services/app_database/app_database.dart';
import '../../shared_widgets/glass.dart';
import 'widgets/sym_feedback_view.dart';

/// One saved attempt in full — its versions (v1, v2, …), each with the text and
/// AI natural rewrite, plus the optional voice recording. Opened from the
/// history list, optionally at a specific version.
class SymSessionDetailPage extends StatefulWidget {
  const SymSessionDetailPage({
    super.key,
    required this.row,
    required this.title,
    this.initialIndex = 0,
  });

  final SymSessionTableData row;
  final String title;
  final int initialIndex;

  @override
  State<SymSessionDetailPage> createState() => _SymSessionDetailPageState();
}

class _SymSessionDetailPageState extends State<SymSessionDetailPage> {
  final SymSessionRepository _repo = SymSessionRepository();
  final AudioPlayer _player = AudioPlayer();

  late SymSessionTableData _row = widget.row;
  late List<SymVersion> _versions = _parse(_row);
  late int _index =
      widget.initialIndex.clamp(0, _versions.length - 1).toInt();
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player.playerStateStream.listen((s) {
      final playing =
          s.playing && s.processingState != ProcessingState.completed;
      if (mounted && playing != _playing) setState(() => _playing = playing);
      if (s.processingState == ProcessingState.completed) _player.stop();
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  static List<SymVersion> _parse(SymSessionTableData row) {
    final raw = row.versionsJson;
    if (raw != null && raw.trim().isNotEmpty) {
      try {
        final list = (jsonDecode(raw) as List)
            .map((e) => SymVersion.fromJson((e as Map).cast<String, dynamic>()))
            .toList()
          ..sort((a, b) => a.version.compareTo(b.version));
        if (list.isNotEmpty) return list;
      } catch (_) {}
    }
    // Legacy / single-version fallback from the summary columns.
    return [
      SymVersion(
        version: 1,
        text: row.finalText,
        score: row.score ?? 0,
        band: row.band ?? 'good',
        naturalVersion: row.naturalVersion ?? '',
        tokens: row.tokens,
      ),
    ];
  }

  Future<void> _togglePlay(String path) async {
    if (_playing) {
      await _player.pause();
      return;
    }
    try {
      await _player.setFilePath(path);
      await _player.play();
    } catch (_) {}
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this entry?'),
        content: const Text(
            'This removes the saved writing and its recording from this device.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    await _player.stop();
    await _repo.delete(_row);
    // Return the deleted id so the history list can drop it instantly.
    if (mounted) Navigator.pop(context, _row.id);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final v = _versions[_index];
    final band = _band(v.band, v.score);
    final recPath = _row.recordingPath;
    final hasRecording = recPath != null && File(recPath).existsSync();
    final words =
        v.text.trim().isEmpty ? 0 : v.text.trim().split(RegExp(r'\s+')).length;

    return GlassScaffold(
      title: Text(widget.title),
      actions: [
        IconButton(
          tooltip: 'Delete',
          onPressed: _delete,
          icon: const Icon(Icons.delete_outline_rounded),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          // Version switcher (only when there's a chain).
          if (_versions.length > 1) ...[
            Text('Versions',
                style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < _versions.length; i++)
                  _VersionChip(
                    version: _versions[i].version,
                    score: _versions[i].score,
                    tokens: _versions[i].tokens,
                    selected: i == _index,
                    color: _band(_versions[i].band, _versions[i].score).color,
                    onTap: () => setState(() => _index = i),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          // Header: band + score + meta.
          GlassCard(
            blur: false,
            highlight: true,
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: band.color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: band.color.withValues(alpha: 0.4)),
                  ),
                  child: Text('${v.score}',
                      style: PmpTextStyles.title1SemiBold
                          .copyWith(color: band.color)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(band.label,
                          style: PmpTextStyles.body1Semi
                              .copyWith(color: cs.onSurface)),
                      const SizedBox(height: 2),
                      Text(
                        '${_fmtDate(_row.createdAt)} · $words words'
                        '${v.tokens > 0 ? ' · ${_fmtTokens(v.tokens)} tok' : ''}',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: mm),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('What you wrote',
              style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
          const SizedBox(height: 8),
          GlassCard(
            blur: false,
            child: Text(v.text,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.55)),
          ),
          // Full saved feedback (corrections, strengths, use-more, next step) —
          // same renderer as the live screen. Legacy rows have no feedback, so
          // fall back to just the natural rewrite.
          if (v.feedback != null) ...[
            const SizedBox(height: 16),
            SymFeedbackContent(feedback: v.feedback!, showCoachCard: false),
          ] else if (v.naturalVersion.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('A natural way to say it',
                style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: PmpColors.brandCyan.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.3)),
              ),
              child: Text(v.naturalVersion,
                  style: PmpTextStyles.body2Medium
                      .copyWith(color: cs.onSurface, height: 1.55)),
            ),
          ],
          if (hasRecording) ...[
            const SizedBox(height: 16),
            Text('Your recording',
                style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _togglePlay(recPath),
              style:
                  OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              icon: Icon(
                  _playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
              label: Text(_playing ? 'Pause' : 'Play my voice'),
            ),
          ],
          const SizedBox(height: 24),
          // Re-enter the produce flow for this topic — write a fresh version,
          // get new feedback, and read it aloud again.
          FilledButton.icon(
            onPressed: _polishAndRetry,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              textStyle: PmpTextStyles.body1Semi,
            ),
            icon: const Icon(Icons.edit_note_rounded),
            label: const Text('Polish & retry'),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'ဒီ topic ကို ပြန်ရေးပြီး အသစ် feedback ယူကြည့်ပါ။',
              textAlign: TextAlign.center,
              style: PmpTextStyles.label2Regular.copyWith(color: mm),
            ),
          ),
        ],
      ),
    );
  }

  /// Continue this attempt's chain — resume from the latest version so a new
  /// pass appends (v2 → v3) to this same entry rather than starting over. On
  /// return, reload the row so the new version chips appear immediately.
  Future<void> _polishAndRetry() async {
    final saved = await Navigator.pushNamed(
      context,
      PmpRoutes.speakYourMindProduce,
      arguments: {
        'id': _row.topicId,
        'resumeSessionId': _row.id,
        'resumeVersions': _versions,
        'resumeRecordingPath': _row.recordingPath,
      },
    );
    if (saved == true) {
      final fresh = await _repo.getById(_row.id);
      if (fresh != null && mounted) {
        setState(() {
          _row = fresh;
          _versions = _parse(fresh);
          _index = _versions.length - 1;
        });
      }
    }
  }
}

({Color color, String label}) _band(String band, int score) {
  // Prefer the stored band; fall back to score thresholds.
  final b = band.isNotEmpty
      ? band
      : (score >= 85 ? 'great' : (score >= 65 ? 'good' : 'keep_going'));
  return switch (b) {
    'great' => (color: PmpColors.success500, label: 'Great'),
    'keep_going' => (color: PmpColors.brandOrange, label: 'Keep going'),
    _ => (color: PmpColors.brandCyan, label: 'Good'),
  };
}

class _VersionChip extends StatelessWidget {
  const _VersionChip({
    required this.version,
    required this.score,
    required this.selected,
    required this.color,
    required this.onTap,
    this.tokens = 0,
  });
  final int version;
  final int score;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  /// Tokens this version billed — shown so each version's cost is visible.
  final int tokens;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.16)
              : cs.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? color : cs.outlineVariant,
              width: selected ? 1.5 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('v$version',
                style: PmpTextStyles.labelSemi.copyWith(color: color)),
            const SizedBox(width: 6),
            Text('$score',
                style:
                    PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
            if (tokens > 0) ...[
              const SizedBox(width: 6),
              Text('· ${_fmtTokens(tokens)} tok',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
            ],
          ],
        ),
      ),
    );
  }
}

String _fmtDate(DateTime d) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${d.year}-${two(d.month)}-${two(d.day)}  ${two(d.hour)}:${two(d.minute)}';
}

/// Compact token count: `840`, `1.2k`, `15k`.
String _fmtTokens(int n) {
  if (n < 1000) return '$n';
  final k = n / 1000;
  return '${k.toStringAsFixed(k >= 10 ? 0 : 1)}k';
}
