import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../shared_widgets/glass.dart';
import 'showcase_director.dart';
import 'widgets/caption_overlay.dart';
import 'widgets/showcase_fx.dart';
import 'widgets/scenes/cta_scene.dart';
import 'widgets/scenes/home_scene.dart';
import 'widgets/scenes/hook_scene.dart';
import 'widgets/scenes/lesson_hub_scene.dart';
import 'widgets/scenes/record_scene.dart';
import 'widgets/scenes/shadowing_scene.dart';
import 'widgets/scenes/takeaways_scene.dart';

/// Auto-playing marketing reel. A single [AnimationController] of
/// [kShowcaseDuration] seconds drives every scene, so playback is deterministic
/// and frame-perfect — point a screen recorder at it and capture one loop.
///
/// Default presentation is pure full-bleed (no chrome) for clean recording;
/// tap once to reveal play/restart/close controls for a few seconds.
class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: (kShowcaseDuration * 1000).round()),
  )..repeat();

  bool _showControls = false;
  int _hideToken = 0;

  @override
  void initState() {
    super.initState();
    // Immersive, no status/nav bars — a clean canvas for the recorder.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _revealControls() {
    setState(() => _showControls = true);
    final token = ++_hideToken;
    Timer(const Duration(seconds: 3), () {
      if (mounted && token == _hideToken) {
        setState(() => _showControls = false);
      }
    });
  }

  /// Cross-fade envelope for a scene window at master time [t] (seconds).
  double _opacityFor(SceneWindow w, double t) {
    if (t <= w.start - 0.01 || t >= w.end + 0.01) return 0;
    final fadeIn = seg(t, w.start, w.start + kCrossfade);
    final fadeOut = 1 - seg(t, w.end - kCrossfade, w.end);
    return (fadeIn * fadeOut).clamp(0.0, 1.0);
  }

  Widget _sceneFor(ShowcaseScene scene, double localT) {
    switch (scene) {
      case ShowcaseScene.hook:
        return HookScene(t: localT);
      case ShowcaseScene.home:
        return HomeScene(t: localT);
      case ShowcaseScene.lessonHub:
        return LessonHubScene(t: localT);
      case ShowcaseScene.shadowing:
        return ShadowingScene(t: localT);
      case ShowcaseScene.takeaways:
        return TakeawaysScene(t: localT);
      case ShowcaseScene.record:
        return RecordScene(t: localT);
      case ShowcaseScene.cta:
        return CtaScene(t: localT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _revealControls,
        child: GradientBackground(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value * kShowcaseDuration;

              // Mount only the active (opacity > 0) scenes so per-loop state
              // (e.g. the CTA confetti) resets cleanly on re-entry.
              final layers = <Widget>[];
              SceneWindow? dominant;
              double dominantOp = 0;
              for (final w in kSceneWindows) {
                final op = _opacityFor(w, t);
                if (op <= 0.001) continue;
                if (op >= dominantOp) {
                  dominantOp = op;
                  dominant = w;
                }
                layers.add(
                  Opacity(
                    key: ValueKey(w.scene),
                    opacity: op,
                    child: IgnorePointer(
                      child: _sceneFor(w.scene, t - w.start),
                    ),
                  ),
                );
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  ...layers,
                  if (dominant != null) ...[
                    Opacity(
                      opacity: dominantOp,
                      child: const BottomScrim(),
                    ),
                    Opacity(
                      opacity: dominantOp,
                      child: Stack(
                        children: [
                          CaptionOverlay(
                            caption: kCaptions[dominant.scene]!,
                            localT: t - dominant.start,
                            sceneDuration: dominant.duration,
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (_showControls) _controls(t),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _controls(double t) {
    final playing = _controller.isAnimating;
    return SafeArea(
      child: Stack(
        children: [
          // Close.
          Positioned(
            top: 8,
            right: 8,
            child: GlassBackButtonLike(
              icon: Symbols.close,
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ),
          // Transport.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: t / kShowcaseDuration,
                        minHeight: 4,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlassBackButtonLike(
                        icon: Symbols.replay,
                        onTap: () {
                          _controller.value = 0;
                          _controller.repeat();
                          _revealControls();
                        },
                      ),
                      const SizedBox(width: 18),
                      GlassBackButtonLike(
                        icon: playing ? Symbols.pause : Symbols.play_arrow,
                        onTap: () {
                          if (playing) {
                            _controller.stop();
                          } else {
                            _controller.repeat();
                          }
                          _revealControls();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A circular glass icon button (close / replay / play) matching the app's
/// [GlassBackButton] look, but with a configurable icon + action.
class GlassBackButtonLike extends StatelessWidget {
  const GlassBackButtonLike({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
    );
  }
}
