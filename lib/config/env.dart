import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static const _required = [
    'SUPABASE_URL',
    'SUPABASE_ANON_KEY',
    'BUNNY_SPOKEN_PATTERN_API_KEY',
    'BUNNY_LISTENING_API_KEY',
    'PRIVACY_POLICY',
  ];

  /// Call once in main() immediately after dotenv.load().
  /// Throws a [StateError] listing every missing key so the
  /// developer knows exactly what to add to the .env file.
  static void validate() {
    final missing = _required.where((k) => dotenv.env[k] == null).toList();
    if (missing.isNotEmpty) {
      throw StateError(
        'Missing required environment variables: $missing\n'
        'Copy .envs/.env.example to .envs/.env.<flavor> and fill in the values.',
      );
    }
  }

  static String get supabaseURL => dotenv.env['SUPABASE_URL']!;
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY']!;
  static String get bunnySpokenPatternAPIKey =>
      dotenv.env['BUNNY_SPOKEN_PATTERN_API_KEY']!;
  static String get bunnyListeningAPIKey =>
      dotenv.env['BUNNY_LISTENING_API_KEY']!;
  static String get privacyPolicyUrl => dotenv.env['PRIVACY_POLICY']!;

  /// Google OAuth web client ID — used as the `serverClientId` for native Google
  /// sign-in and registered in Supabase's Google provider. Not in [_required] so
  /// the app still boots before Google login is configured; the auth repository
  /// surfaces a clear error if it's missing when a user taps "Continue with
  /// Google".
  static String? get googleWebClientId => dotenv.env['GOOGLE_WEB_CLIENT_ID'];
}
