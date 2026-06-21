import 'package:flutter_tts/flutter_tts.dart';

/// Thin singleton around the device's built-in text-to-speech, used to let a
/// learner hear the *correct* English of an AI correction / suggestion (e.g. tap
/// the speaker next to "math" after they said "match"). On-device → free,
/// offline, no server. Single words/short phrases only, so the native voice
/// quality is plenty. Best-effort: any failure is swallowed so the UI never
/// breaks on a device without a usable English voice.
class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final FlutterTts _tts = FlutterTts();
  bool _inited = false;

  Future<void> _ensureInit() async {
    if (_inited) return;
    _inited = true;
    try {
      await _tts.setLanguage('en-US');
      // A touch slower than normal so learners catch the sounds.
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(1.0);
      await _tts.awaitSpeakCompletion(true);
    } catch (_) {
      // Leave _inited true — speak() will just no-op if the engine is unusable.
    }
  }

  /// Speak [text] in English. Stops any current utterance first so rapid taps
  /// don't queue up. No-ops on empty text or TTS failure.
  Future<void> speak(String text) async {
    final t = text.trim();
    if (t.isEmpty) return;
    await _ensureInit();
    try {
      await _tts.stop();
      await _tts.speak(t);
    } catch (_) {
      // Device has no usable TTS — silently ignore.
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}
