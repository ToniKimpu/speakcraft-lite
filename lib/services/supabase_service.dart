import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SupabaseService {
  String getPublicUrl({
    required SupabaseBucketFolders bucketFolder,
    required String? fileName,
  }) {
    final url = supabase.storage.from("contents").getPublicUrl(
          "${bucketFolder.name}/$fileName",
        );
    return url;
  }
}

enum SupabaseBucketFolders {
  spokenPatternAudios('spoken-patterns/audios'),
  listeningAndShadowingAudios('listening-and-shadowing/audios'),
  listeningAndShadowingImages('listening-and-shadowing/images'),
  listeningAndShadowingSubtitles('listening-and-shadowing/subtitles');

  final String name;
  const SupabaseBucketFolders(this.name);
}
