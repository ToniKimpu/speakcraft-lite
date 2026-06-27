import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speakcraft/shared_widgets/error_retry_view.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:speakcraft/bloc/listening/shadowing_line_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/repositories/listening/listening_recording_repository.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:speakcraft/screens/listening_and_shadowing/shadowing_widgets/highlight_types/highlight_background.dart';
import 'package:speakcraft/screens/listening_and_shadowing/shadowing_widgets/highlight_types/highlight_none.dart';

/// PROTOTYPE — "Full talk" recording mode.
///
/// A silent teleprompter: the same `shadowing.json` script the read-along uses
/// scrolls and karaoke-highlights word-by-word, but driven by a virtual
/// [Stopwatch] clock instead of audio. The learner records one continuous take
/// over the whole talk, then plays it back / saves it.
class FullTalkPage extends StatefulWidget {
  const FullTalkPage({super.key, required this.listening});

  final Listening listening;

  @override
  State<FullTalkPage> createState() => _FullTalkPageState();
}

enum _Phase { idle, recording, review }

class _FullTalkPageState extends State<FullTalkPage>
    with SingleTickerProviderStateMixin {
  final _lineBloc = ShadowingLineBloc();
  final _repo = ListeningRecordingRepository();

  // Virtual clock that drives the karaoke highlight (no audio plays).
  late final Ticker _ticker;
  final _clock = Stopwatch();
  final _positionNotifier = ValueNotifier<Duration>(Duration.zero);
  Duration _baseline = Duration.zero; // first word's start
  Duration _endAt = Duration.zero; // last word's end

  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  StreamSubscription? _playerSub;

  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  List<SubtitleLine> _lines = [];
  int _lastScrolledIndex = -1;

  _Phase _phase = _Phase.idle;
  String? _takePath;
  bool _saving = false;
  bool _playing = false;
  bool _highlightOn = true;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    _lineBloc.add(ShadowingLineEvent.parse(widget.listening.shadowingPath));
    _playerSub = _player.playerStateStream.listen((s) {
      if (s.processingState == ProcessingState.completed && mounted) {
        setState(() => _playing = false);
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.stop();
    _playerSub?.cancel();
    _recorder.dispose();
    _player.dispose();
    _lineBloc.close();
    _positionNotifier.dispose();
    super.dispose();
  }

  void _onTick(Duration _) {
    if (_phase != _Phase.recording || !_clock.isRunning) return;
    final pos = _baseline + _clock.elapsed;
    _positionNotifier.value = pos;
    _autoScroll(pos);
    if (pos >= _endAt) _stopTake();
  }

  int _indexFor(Duration pos) {
    final ms = pos.inMilliseconds;
    for (int i = 0; i < _lines.length; i++) {
      final s = (_lines[i].start * 1000).round();
      final e = (_lines[i].end * 1000).round();
      if (ms >= s && ms < e) return i;
    }
    if (_lines.isNotEmpty && ms >= (_lines.last.end * 1000).round()) {
      return _lines.length - 1;
    }
    return -1;
  }

  void _autoScroll(Duration pos) {
    final i = _indexFor(pos);
    if (i < 0 || i == _lastScrolledIndex) return;
    _lastScrolledIndex = i;
    if (_itemScrollController.isAttached) {
      _itemScrollController.scrollTo(
        index: i,
        duration: const Duration(milliseconds: 600),
        alignment: 0.35,
      );
    }
  }

  Future<void> _startTake() async {
    if (_lines.isEmpty) return;
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (status.isPermanentlyDenied) await openAppSettings();
      if (mounted) _snack('Microphone permission is needed to record.');
      return;
    }
    if (!await _recorder.hasPermission()) return;

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/full_take_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, numChannels: 1, bitRate: 128000),
      path: path,
    );
    if (!mounted) return;

    context.read<VideoStepProgressBloc>().add(
          VideoStepProgressEvent.markInProgress(
            widget.listening.youtubeId,
            VideoLessonStep.record,
          ),
        );

    _baseline = Duration(milliseconds: (_lines.first.start * 1000).round());
    _endAt = Duration(milliseconds: (_lines.last.end * 1000).round());
    _lastScrolledIndex = -1;
    _positionNotifier.value = _baseline;
    _clock
      ..reset()
      ..start();
    if (_itemScrollController.isAttached) {
      _itemScrollController.scrollTo(index: 0, duration: const Duration(milliseconds: 250));
    }
    setState(() {
      _takePath = path;
      _phase = _Phase.recording;
    });
  }

  Future<void> _stopTake() async {
    if (_phase != _Phase.recording) return;
    _clock.stop();
    final path = await _recorder.stop();
    if (!mounted) return;
    setState(() {
      _takePath = path ?? _takePath;
      _phase = _Phase.review;
    });
  }

  Future<void> _togglePlay() async {
    final p = _takePath;
    if (p == null) return;
    if (_playing) {
      await _player.pause();
      if (mounted) setState(() => _playing = false);
      return;
    }
    try {
      await _player.setFilePath(p);
      if (!mounted) return;
      setState(() => _playing = true);
      // Don't await: just_audio's play() future only completes when playback
      // ends — awaiting it would delay the label flip until the take finishes.
      unawaited(_player.play());
    } catch (e) {
      if (mounted) {
        setState(() => _playing = false);
        _snack('Playback failed: $e');
      }
    }
  }

  Future<void> _reRecord() async {
    if (_playing) await _player.stop();
    final p = _takePath;
    if (p != null) {
      try {
        final f = File(p);
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
    _positionNotifier.value = Duration.zero;
    _lastScrolledIndex = -1;
    if (mounted) {
      setState(() {
        _takePath = null;
        _playing = false;
        _phase = _Phase.idle;
      });
    }
  }

  Future<void> _saveTake() async {
    final p = _takePath;
    if (p == null) return;
    setState(() => _saving = true);
    try {
      await _repo.save(
        listeningId: widget.listening.id,
        sentenceId: 'FULL',
        audio: File(p),
      );
      if (!mounted) return;
      context.read<VideoStepProgressBloc>().add(
            VideoStepProgressEvent.markDone(
              widget.listening.youtubeId,
              VideoLessonStep.record,
            ),
          );
      _snack('Full take saved.');
      _positionNotifier.value = Duration.zero;
      setState(() {
        _saving = false;
        _takePath = null;
        _phase = _Phase.idle;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      _snack('Save failed: $e');
    }
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  static String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final appBarFg = Theme.of(context).appBarTheme.foregroundColor ??
        Theme.of(context).colorScheme.onSurface;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        title: const Text('Full talk'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => setState(() => _highlightOn = !_highlightOn),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: appBarFg.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_highlightOn ? Icons.highlight : Icons.highlight_off,
                      size: 16, color: appBarFg),
                  const SizedBox(width: 6),
                  Text(_highlightOn ? 'Highlight' : 'No highlight',
                      style: TextStyle(fontSize: 13, color: appBarFg)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ShadowingLineBloc, ShadowingLineState>(
        bloc: _lineBloc,
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => ErrorRetryView(
              error: msg,
              title: 'Could not load the script',
              onRetry: () => _lineBloc.add(
                ShadowingLineEvent.parse(widget.listening.shadowingPath),
              ),
            ),
            loaded: (lines) {
              _lines = lines;
              return Column(
                children: [
                  Expanded(child: _buildTeleprompter(lines)),
                  _buildControls(),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildTeleprompter(List<SubtitleLine> lines) {
    return ScrollablePositionedList.separated(
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemCount: lines.length,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      itemBuilder: (context, index) {
        final line = lines[index];
        // Highlight off → plain scrolling text (no per-frame rebuild).
        if (!_highlightOn) return HighlightNone(subtitleLine: line);
        return RepaintBoundary(
          child: ValueListenableBuilder<Duration>(
            valueListenable: _positionNotifier,
            builder: (_, position, __) => HighlightBackground(
              subtitleLine: line,
              position: position,
              onSeek: (_) {},
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 14),
    );
  }

  Widget _buildControls() {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: cs.surface,
          border: Border(top: BorderSide(color: cs.outlineVariant)),
        ),
        child: switch (_phase) {
          _Phase.idle => _buildIdle(cs),
          _Phase.recording => _buildRecording(cs),
          _Phase.review => _buildReview(cs),
        },
      ),
    );
  }

  Widget _buildIdle(ColorScheme cs) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Record the whole talk in one go. The script scrolls at the speaker’s '
          'pace — read along and speak. No audio plays.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.5),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _lines.isEmpty ? null : _startTake,
            icon: const Icon(Icons.mic),
            label: const Text('Start full take'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
        ),
      ],
    );
  }

  Widget _buildRecording(ColorScheme cs) {
    final total = (_endAt - _baseline).inMilliseconds;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<Duration>(
          valueListenable: _positionNotifier,
          builder: (_, pos, __) {
            final done = (pos - _baseline).inMilliseconds.clamp(0, total);
            final value = total > 0 ? done / total : 0.0;
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 6,
                    backgroundColor: cs.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fiber_manual_record,
                        size: 12, color: cs.error),
                    const SizedBox(width: 6),
                    Text('Recording  ${_fmt(pos - _baseline)}',
                        style: TextStyle(
                            fontSize: 12.5, color: cs.onSurfaceVariant)),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _stopTake,
            icon: const Icon(Icons.stop),
            label: const Text('Stop'),
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
              foregroundColor: cs.onError,
              minimumSize: const Size.fromHeight(52),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReview(ColorScheme cs) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Your full take is ready.',
            style: TextStyle(fontSize: 13, color: cs.onSurface)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _togglePlay,
                icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                label: Text(_playing ? 'Pause' : 'Play'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _saving ? null : _reRecord,
                icon: const Icon(Icons.refresh),
                label: const Text('Re-record'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _saving ? null : _saveTake,
            icon: _saving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_alt),
            label: Text(_saving ? 'Saving…' : 'Save take'),
            style: FilledButton.styleFrom(
                backgroundColor: PmpColors.success500,
                minimumSize: const Size.fromHeight(50)),
          ),
        ),
      ],
    );
  }
}
