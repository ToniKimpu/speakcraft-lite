/// Computes Bunny CDN URLs for vocabulary audio — clips are **never stored** in
/// the content; their path is derived from (level, group id, word, example).
/// So shipping audio is a one-column `has_audio` flip, not a content rewrite.
///
/// The [slug] rule MUST stay byte-for-byte identical to the Bunny upload script
/// (`scratchpad/bunny_vocab_audio.py`), or the app would request wrong filenames.
library;

import '../../config/env.dart';
import 'vocab_models.dart';

class VocabAudio {
  VocabAudio._();

  static const _levelFolder = {1: 'beginner', 2: 'intermediate', 3: 'upper'};

  /// lowercase → drop apostrophes → non-alphanumeric runs to '-' → trim '-'.
  /// "What's the time?" → "whats-the-time"; "a family of five" → "a-family-of-five".
  static String slug(String word) {
    final noApos = word.toLowerCase().replaceAll(RegExp("['’]"), '');
    final dashed = noApos.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    return dashed.replaceAll(RegExp(r'^-+|-+$'), '');
  }

  static String _level(int level) => _levelFolder[level] ?? 'beginner';

  /// Stored-form path (e.g. `bunny/beginner/feelings/happy.mp3`).
  static String wordBunnyPath(VocabGroup g, int wordIndex) =>
      'bunny/${_level(g.level)}/${g.id}/${slug(g.words[wordIndex].word)}.mp3';

  static String exampleBunnyPath(VocabGroup g, int wordIndex, int exampleIndex) =>
      'bunny/${_level(g.level)}/${g.id}/'
      '${slug(g.words[wordIndex].word)}-ex${exampleIndex + 1}.mp3';

  /// Full CDN URL for a word's clip, or null when audio isn't available
  /// (group not yet audio-enabled, or the CDN base is unconfigured) → use TTS.
  static String? wordUrl(VocabGroup g, int wordIndex) =>
      _resolve(g.hasAudio ? wordBunnyPath(g, wordIndex) : null);

  static String? exampleUrl(VocabGroup g, int wordIndex, int exampleIndex) =>
      _resolve(g.hasAudio ? exampleBunnyPath(g, wordIndex, exampleIndex) : null);

  static String? _resolve(String? bunnyPath) {
    if (bunnyPath == null) return null;
    final base = Env.bunnyVocabBaseUrl;
    if (base.isEmpty) return null;
    return base + bunnyPath.replaceFirst('bunny/', '');
  }
}
