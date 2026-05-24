import 'package:speakcraft/config/env.dart';

import 'supabase_service.dart';

class AudioUrlService {
  static const String supabasePrefix = "supabase/";
  static const String bunnyPrefix = "bunny/";

  static String resolveAudioUrl(String originalUrl) {
    if (originalUrl.startsWith(supabasePrefix)) {
      return _resolveSupabaseUrl(originalUrl);
    }
    if (originalUrl.startsWith(bunnyPrefix)) {
      return _resolveBunnyUrl(originalUrl);
    }
    throw ArgumentError("Unsupported audio URL format: $originalUrl");
  }

  static String _resolveSupabaseUrl(String originalUrl) {
    final fileName = originalUrl.replaceFirst(supabasePrefix, "");
    return SupabaseService().getPublicUrl(
      bucketFolder: SupabaseBucketFolders.spokenPatternAudios,
      fileName: fileName,
    );
  }

  static String _resolveBunnyUrl(String originalUrl) {
    final relativePath = originalUrl.replaceFirst(bunnyPrefix, "");
    return Env.bunnySpokenPatternAPIKey + relativePath;
  }
}
