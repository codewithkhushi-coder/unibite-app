import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase. For dummy data/testing phase, fallbacks are managed internally
  try {
    await Supabase.initialize(
      url: 'http://127.0.0.1:54321', // Local testing URL
      anonKey: 'eyJh...' // Replace with actual anonymous key later
    );
  } catch (e) {
    debugPrint('Supabase init failed (Running offline mode): \$e');
  }
  
  runApp(
    // ProviderScope initializes Riverpod
    const ProviderScope(
      child: UniBiteApp(),
    ),
  );
}
