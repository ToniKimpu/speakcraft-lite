import 'package:flutter_tts/flutter_tts.dart';

/// Fallback audio for vocabulary: on-device TTS.
///
/// Production plays pre-generated EdgeTTS clips from Bunny when a group is
/// audio-enabled — the URL is *computed* (see `vocab_audio.dart`), and the UI
/// falls back to this service when no clip is available.
class VocabTtsService {
  VocabTtsService._();
  static final VocabTtsService instance = VocabTtsService._();

  final FlutterTts _tts = FlutterTts();
  bool _ready = false;

  Future<void> _ensure() async {
    if (_ready) return;
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45); // a touch slower — clearer for learners
    await _tts.setPitch(1.0);
    _ready = true;
  }

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _ensure();
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() => _tts.stop();
}
