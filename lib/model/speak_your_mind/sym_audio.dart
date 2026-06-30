/// Resolves a stored Speak Your Mind audio path to a full Bunny CDN URL.
///
/// Clips live on Bunny at `speak_your_mind/level{N}/<topic>/<file>.mp3`; the JSON
/// stores the path as `bunny/speak_your_mind/level{N}/<topic>/<file>.mp3`. We
/// strip the `bunny/` marker and prepend [Env.bunnySymBaseUrl] (the CDN root),
/// mirroring `VocabAudio._resolve`. Returns null when the path is empty or the
/// base is unconfigured → the player falls back to on-device TTS.
library;

import '../../config/env.dart';

class SymAudio {
  SymAudio._();

  static String? resolve(String? storedPath) {
    if (storedPath == null || storedPath.isEmpty) return null;
    final base = Env.bunnySymBaseUrl;
    if (base.isEmpty) return null;
    return base + storedPath.replaceFirst('bunny/', '');
  }
}
