import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String supabaseURL = dotenv.env['SUPABASE_URL']!;
  static String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  // static String webClientId = dotenv.env['WEB_CLIENT_ID']!;
}
