import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

enum SupabaseBucketFolders {
  storesAudioSpokenPatterns('audios/spoken-patterns');

  final String name;
  const SupabaseBucketFolders(this.name);
}