import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

/// Record → play back → re-record a voice take, saved as a local `.m4a` in the
/// app documents directory. Reports the current file path (or null) via
/// [onChanged]. Nothing is uploaded — this is a private self-listening aid.
class SymRecorder extends StatefulWidget {
  const SymRecorder({super.key, required this.onChanged});

  /// Called with the recording's path when one exists, or null when cleared.
  final ValueChanged<String?> onChanged;

  @override
  State<SymRecorder> createState() => _SymRecorderState();
}

class _SymRecorderState extends State<SymRecorder> {
  final AudioRecorder _rec = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _playSub;

  String? _path;
  bool _recording = false;
  bool _busy = false;
  bool _playing = false;
  bool _denied = false;

  @override
  void initState() {
    super.initState();
    _playSub = _player.playerStateStream.listen((s) {
      final playing =
          s.playing && s.processingState != ProcessingState.completed;
      if (mounted && playing != _playing) setState(() => _playing = playing);
      if (s.processingState == ProcessingState.completed) {
        _player.stop();
      }
    });
  }

  @override
  void dispose() {
    _playSub?.cancel();
    _rec.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (!await _rec.hasPermission()) {
        if (mounted) {
          setState(() {
            _denied = true;
            _busy = false;
          });
        }
        return;
      }
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/sym_take_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _rec.start(
        const RecordConfig(
            encoder: AudioEncoder.aacLc, numChannels: 1, bitRate: 128000),
        path: path,
      );
      if (mounted) {
        setState(() {
          _recording = true;
          _denied = false;
          _busy = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _stop() async {
    if (_busy) return;
    setState(() => _busy = true);
    final path = await _rec.stop();
    if (mounted) {
      setState(() {
        _recording = false;
        _path = path;
        _busy = false;
      });
    }
    widget.onChanged(path);
  }

  Future<void> _togglePlay() async {
    if (_path == null) return;
    if (_playing) {
      await _player.pause();
      return;
    }
    try {
      await _player.setFilePath(_path!);
      await _player.play();
    } catch (_) {}
  }

  Future<void> _reRecord() async {
    await _player.stop();
    final old = _path;
    if (mounted) setState(() => _path = null);
    widget.onChanged(null);
    if (old != null) {
      try {
        final f = File(old);
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
    await _start();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);

    final Widget control;
    if (_recording) {
      control = FilledButton.icon(
        onPressed: _busy ? null : _stop,
        style: FilledButton.styleFrom(
          backgroundColor: PmpColors.brandOrange,
          minimumSize: const Size.fromHeight(50),
          textStyle: PmpTextStyles.body1Semi,
        ),
        icon: const Icon(Icons.stop_rounded),
        label: const Text('Stop recording'),
      );
    } else if (_path != null) {
      // Stacked (no Row/Expanded) so it always has a bounded size in any parent.
      control = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.tonalIcon(
            onPressed: _togglePlay,
            style:
                FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            icon: Icon(
                _playing ? Icons.pause_rounded : Icons.play_arrow_rounded),
            label: Text(_playing ? 'Pause' : 'Play my voice'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _busy ? null : _reRecord,
            style:
                OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Redo recording'),
          ),
        ],
      );
    } else {
      control = OutlinedButton.icon(
        onPressed: _busy ? null : _start,
        style:
            OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        icon: const Icon(Icons.mic_rounded),
        label: const Text('Record your voice'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        control,
        if (_recording) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fiber_manual_record,
                  size: 12, color: PmpColors.brandOrange),
              const SizedBox(width: 6),
              Text('Recording…',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ],
        if (_denied) ...[
          const SizedBox(height: 8),
          Text(
            'မိုက်ခရိုဖုန်း ခွင့်ပြုချက် လိုအပ်ပါတယ်။ Settings မှာ ဖွင့်ပေးပါ။',
            textAlign: TextAlign.center,
            style: PmpTextStyles.label2Regular.copyWith(color: mm),
          ),
        ],
      ],
    );
  }
}
