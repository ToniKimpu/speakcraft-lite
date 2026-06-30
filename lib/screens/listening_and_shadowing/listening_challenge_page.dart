import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/listening/subtitle_parsing_bloc.dart';
import '../../bloc/video_step_progress/video_step_progress_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/listening/listening.dart';
import '../../model/sentence_explanation/sentence_explanation.dart';
import '../../model/subtitle/subtitle.dart';
import '../../model/video_step_progress/video_step_progress.dart';
import '../../repositories/listening/listening_challenge_repository.dart';
import '../../shared_widgets/glass.dart';
import 'shadowing_widgets/shadowing_player.dart';

/// Listening Challenge — the "graduation" step. Play the lesson video with NO
/// subtitles; tap **Mark** whenever a sentence slips by. Each mark snaps to the
/// sentence playing-or-just-ended, then a review reveals exactly those sentences
/// with a "you caught X of Y by ear" score.
///
/// Reuses the proven shadowing player (YoutubePlayerBuilder + ShadowingPlayer)
/// for rock-solid loading + transport; the small video is covered by the lesson
/// thumbnail so neither the picture nor any caption is visible.
class ListeningChallengePage extends StatelessWidget {
  const ListeningChallengePage({super.key, required this.listening});
  final Listening listening;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SubtitleParsingBloc()..add(SubtitleParsingEvent.parse(listening)),
      child: _ChallengeView(listening: listening),
    );
  }
}

class _ChallengeView extends StatefulWidget {
  const _ChallengeView({required this.listening});
  final Listening listening;

  @override
  State<_ChallengeView> createState() => _ChallengeViewState();
}

class _ChallengeViewState extends State<_ChallengeView>
    with SingleTickerProviderStateMixin {
  final ListeningChallengeRepository _repo = ListeningChallengeRepository();
  late final YoutubePlayerController _controller;

  List<Subtitle> _subs = const [];
  final Set<int> _marked = {};
  bool _review = false;

  /// While leaving: swap the body to a spinner so the YouTube player is gone
  /// before the pop transition (no flashing player), then pop — like the watch
  /// and shadowing pages.
  bool _backPressed = false;

  // Smooth 60fps slider: extrapolate wall-clock between the controller's ~4Hz
  // updates and snap a baseline on each real update (copied from shadowing).
  final ValueNotifier<Duration> _position = ValueNotifier(Duration.zero);
  late final Ticker _ticker = createTicker(_onExtrapolationTick);
  Duration _baseline = Duration.zero;
  final Stopwatch _sinceBaseline = Stopwatch();

  String get _yid => widget.listening.youtubeId.trim();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _yid,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        hideThumbnail: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
        startAt: widget.listening.start,
        endAt: widget.listening.end,
      ),
    )..addListener(_onPlayerPositionChanged);
    _ticker.start();
    _loadMarks();
  }

  Future<void> _loadMarks() async {
    final idx = await _repo.markedIndices(_yid);
    if (mounted) setState(() => _marked.addAll(idx));
  }

  void _onExtrapolationTick(Duration _) {
    if (_sinceBaseline.isRunning) {
      _position.value = _baseline + _sinceBaseline.elapsed;
    }
  }

  void _onPlayerPositionChanged() {
    if (!mounted) return;
    _baseline = _controller.value.position;
    _sinceBaseline
      ..reset()
      ..start();
    if (!_controller.value.isPlaying) _sinceBaseline.stop();
    _position.value = _baseline;
  }

  void _togglePlay() {
    final v = _controller.value;
    if (v.playerState == PlayerState.buffering || !v.isReady) return;
    if (v.playerState == PlayerState.ended) {
      _controller.seekTo(Duration(seconds: widget.listening.start));
      _controller.play();
    } else if (v.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _controller.dispose();
    _position.dispose();
    super.dispose();
  }

  /// The sentence playing-or-just-ended at [pos] = the latest one whose start
  /// is at/before the mark (handles the natural reaction lag).
  int _mapToSentence(Duration pos) {
    var idx = 0;
    for (var i = 0; i < _subs.length; i++) {
      if (_subs[i].start <= pos) {
        idx = i;
      } else {
        break;
      }
    }
    return idx;
  }

  void _mark() {
    if (_subs.isEmpty) return;
    final pos = _controller.value.position;
    final idx = _mapToSentence(pos);
    // Quiet & frictionless — no toast; the "N marked" count updates instead so
    // they stay in the flow of listening.
    if (_marked.add(idx)) _repo.addMark(_yid, idx, pos.inMilliseconds);
    setState(() {});
  }

  /// Leave the screen — hide the player first, then pop after a short beat.
  void _exit() {
    if (_backPressed) return;
    _controller.pause();
    setState(() => _backPressed = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  void _toReview() {
    _controller.pause();
    context
        .read<VideoStepProgressBloc>()
        .add(VideoStepProgressEvent.markDone(_yid, VideoLessonStep.challenge));
    setState(() => _review = true);
  }

  void _unmark(int idx) {
    setState(() => _marked.remove(idx));
    _repo.removeMark(_yid, idx);
  }

  void _explain(Subtitle sub) {
    final se = SentenceExplanation(
      id: 1,
      start: sub.start.inSeconds.toDouble(),
      end: sub.end.inSeconds.toDouble(),
      english: sub.english,
      burmese: sub.burmese ?? '',
      explanationUrl: sub.explanationUrl,
    );
    Navigator.pushNamed(context, PmpRoutes.sentenceExplanationPage,
        arguments: {'sentence_explanation': se});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _exit();
      },
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: false,
          onReady: () {},
        ),
        builder: (context, player) {
          if (_backPressed) {
            return const GradientBackground(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          return GlassScaffold(
            title: const Text('Listening Challenge'),
            body: BlocConsumer<SubtitleParsingBloc, SubtitleParsingState>(
              listener: (context, state) {
                state.maybeWhen(
                  loaded: (subs) => setState(() => _subs = subs),
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  error: (m) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(m, textAlign: TextAlign.center),
                    ),
                  ),
                  loaded: (_) =>
                      _review ? _buildReview(player) : _buildListen(player),
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// The shadowing transport bar, fed a player whose video is covered by the
  /// lesson thumbnail so no picture/caption shows.
  Widget _shadowingBar(Widget player) {
    return ShadowingPlayer(
      listening: widget.listening,
      controller: _controller,
      player: Stack(
        fit: StackFit.expand,
        children: [
          player,
          // Cover the tiny video → audio only, captions impossible to see.
          CachedNetworkImage(
            imageUrl: widget.listening.thumbnail,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) =>
                const ColoredBox(color: Color(0xFF0E1216)),
          ),
        ],
      ),
      positionListenable: _position,
      totalDuration: Duration(seconds: widget.listening.end),
      enableSpeedControl: true,
      onTogglePlay: _togglePlay,
    );
  }

  // ── Listen stage ───────────────────────────────────────────────────────────

  Widget _buildListen(Widget player) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Column(
      children: [
        const SizedBox(height: 12),
        _shadowingBar(player),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            children: [
              Text('Listen without subtitles',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
              const SizedBox(height: 6),
              Text(
                'Tap “Mark” whenever a sentence slips by — don’t stop, just keep '
                'listening. You’ll review what you missed at the end.',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.5),
              ),
              const SizedBox(height: 4),
              Text(
                'subtitle မပါဘဲ နားထောင်ပါ — နားမလည်တဲ့ ဝါကျဆို “Mark” နှိပ်ပါ။ '
                'မရပ်ပါနဲ့၊ ဆက်နားထောင်ပါ။ နောက်မှ ပြန်လေ့လာရပါမယ်။',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: mm, height: 1.5),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  _marked.isEmpty
                      ? 'Nothing marked yet'
                      : '${_marked.length} sentence${_marked.length == 1 ? '' : 's'} marked',
                  style: PmpTextStyles.body2Semi.copyWith(
                      color:
                          _marked.isEmpty ? cs.onSurfaceVariant : cs.primary),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: _mark,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: PmpColors.brandOrange,
                    foregroundColor: Colors.white,
                    textStyle: PmpTextStyles.body1Semi,
                  ),
                  icon: const Icon(Icons.flag_rounded),
                  label: const Text("Mark — I didn't catch that"),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _toReview,
                  child: Text(_marked.isEmpty
                      ? 'Finish & review'
                      : 'Finish & review (${_marked.length})'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Review stage ─────────────────────────────────────────────────────────

  Widget _buildReview(Widget player) {
    final cs = Theme.of(context).colorScheme;
    final total = _subs.length;
    final caught = (total - _marked.length).clamp(0, total);
    final sorted = _marked.toList()..sort();

    return Column(
      children: [
        // Keep the player mounted (YoutubePlayerBuilder needs it in the tree, and
        // "Try again" reuses it) but hidden — no player UI on review/finish.
        Offstage(child: player),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              GlassCard(
                blur: false,
                highlight: true,
                child: Column(
                  children: [
                    Text('You caught $caught of $total by ear 🎧',
                        textAlign: TextAlign.center,
                        style: PmpTextStyles.title1SemiBold
                            .copyWith(color: cs.onSurface)),
                    const SizedBox(height: 6),
                    Text(
                      sorted.isEmpty
                          ? 'Perfect — you understood every sentence without subtitles!'
                          : 'These are the ones you marked. Read them, replay above, then try again.',
                      textAlign: TextAlign.center,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final i in sorted) ...[
                _MarkedSentenceCard(
                  number: i + 1,
                  subtitle: _subs[i],
                  onExplain: _subs[i].explanationUrl.trim().isEmpty
                      ? null
                      : () => _explain(_subs[i]),
                  onGotIt: () => _unmark(i),
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() => _review = false);
                  _controller.seekTo(Duration(seconds: widget.listening.start));
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Try again'),
              ),
              const SizedBox(height: 10),
              FilledButton(
                onPressed: _exit,
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52)),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MarkedSentenceCard extends StatelessWidget {
  const _MarkedSentenceCard({
    required this.number,
    required this.subtitle,
    required this.onExplain,
    required this.onGotIt,
  });
  final int number;
  final Subtitle subtitle;
  final VoidCallback? onExplain;
  final VoidCallback onGotIt;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return GlassCard(
      blur: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$number',
                  style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(subtitle.english,
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: cs.onSurface, height: 1.45)),
              ),
            ],
          ),
          if ((subtitle.burmese ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(subtitle.burmese!,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: mm, height: 1.45)),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              if (onExplain != null)
                TextButton.icon(
                  onPressed: onExplain,
                  icon: const Icon(Icons.menu_book_outlined, size: 18),
                  label: const Text('Explain'),
                ),
              const Spacer(),
              TextButton.icon(
                onPressed: onGotIt,
                icon: const Icon(Icons.check_rounded, size: 18),
                label: const Text('Got it now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
