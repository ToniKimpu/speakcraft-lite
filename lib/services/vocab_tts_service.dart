import 'package:flutter_tts/flutter_tts.dart';

/// Placeholder audio for the vocabulary **prototype**: on-device TTS.
///
/// Production will instead play pre-generated EdgeTTS clips uploaded to Bunny
/// (via `VocabWord.audioPath` / `VocabExample.audioPath`). Keeping playback
/// behind this one service means that swap is localized.
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
