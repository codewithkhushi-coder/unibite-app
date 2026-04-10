import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

class UniBiteApp extends ConsumerWidget {
  const UniBiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch GoRouter provider for navigation routing
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'UniBite',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // Forcing light mode primarily for purple/white branding
      // Remove or set to ThemeMode.system later if dark mode is fully baked
      themeMode: ThemeMode.light, 
      routerConfig: goRouter,
    );
  }
}
