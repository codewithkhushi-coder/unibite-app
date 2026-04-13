import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Use environment variables for security
  // Pass them via --dart-define=SUPABASE_URL=... and --dart-define=SUPABASE_ANON_KEY=...
  const supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: 'https://hlantiiywvsfkxlrxlsy.supabase.co');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'sb_publishable_i3arh4wAwmuF5TsUSKMwKQ_fZp1YeA9');

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } catch (e) {
    debugPrint('Supabase init failed: $e');
  }
  
  runApp(
    // ProviderScope initializes Riverpod
    const ProviderScope(
      child: UniBiteApp(),
    ),
  );
}
