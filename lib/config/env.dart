import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String supabaseURL = dotenv.env['SUPABASE_URL']!;
  static String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  static String bunnyAudioAPIKey = dotenv.env['BUNNY_AUDIO_API_KEY']!;
  static String bunnyThumbnailAPIKey = dotenv.env['BUNNY_THUMBNAIL_API_KEY']!;
  static String bunnySubtitleAPIKey = dotenv.env['BUNNY_SUBTITLE_API_KEY']!;

  static String privacyPolicyUrl = dotenv.env['PRIVACY_POLICY']!;
  // static String webClientId = dotenv.env['WEB_CLIENT_ID']!;
}
