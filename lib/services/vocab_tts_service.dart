import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

/// Vocabulary audio: plays pre-generated EdgeTTS clips from Bunny when a group
/// is audio-enabled (URL computed in `vocab_audio.dart`), and falls back to
/// on-device TTS when there's no clip — or it fails to load (offline / missing).
class VocabTtsService {
  VocabTtsService._();
  static final VocabTtsService instance = VocabTtsService._();

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _player = AudioPlayer();
  bool _ready = false;

  Future<void> _ensure() async {
    if (_ready) return;
    await _tts.setLanguage('en-GB'); // content is British English
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

  /// Play the pre-generated clip at [url]; if it's null/empty or fails to load
  /// (missing clip, offline), fall back to speaking [text] with TTS.
  Future<void> playUrlOrSpeak(String? url, String text) async {
    await stop();
    if (url != null && url.isNotEmpty) {
      try {
        await _player.setUrl(url);
        _player.play(); // fire-and-forget; don't await completion
        return;
      } catch (_) {
        // clip unavailable → TTS fallback below
      }
    }
    await speak(text);
  }


  Future<void> stop() async {
    await _player.stop();
    await _tts.stop();
  }
}
