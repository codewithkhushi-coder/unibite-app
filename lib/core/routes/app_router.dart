import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/screens/login_screen.dart';
import '../../modules/auth/screens/signup_screen.dart';
import '../../modules/auth/screens/splash_screen.dart';
import '../../modules/auth/screens/role_selection_screen.dart';
import '../../modules/auth/screens/otp_verification_screen.dart';
import '../../modules/auth/screens/set_password_screen.dart';
import '../../modules/auth/controllers/auth_controller.dart';
import '../models/user_role.dart';
import '../../modules/user/widgets/user_home_screen.dart';
import '../../modules/vendor/widgets/vendor_dashboard_screen.dart';
import '../../modules/vendor/widgets/menu_management_screen.dart';
import '../../modules/delivery/widgets/delivery_dashboard_screen.dart';
import '../../modules/admin/widgets/admin_dashboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthRoute = state.uri.path == '/login' || 
                         state.uri.path == '/signup' || 
                         state.uri.path == '/splash' || 
                         state.uri.path == '/role-selection' ||
                         state.uri.path == '/verify-otp' ||
                         state.uri.path == '/set-password';
      
      if (authState == null) {
        // Not logged in: Allow auth routes
        return isAuthRoute ? null : '/splash';
      }

      // If logged in and on an auth route, redirect to correct dashboard
      if (isAuthRoute) {
        switch (authState.role) {
          case UserRole.admin:
            return '/admin-dashboard';
          case UserRole.vendor:
            return '/vendor-dashboard';
          case UserRole.delivery:
            return '/delivery-dashboard';
          case UserRole.user:
          case UserRole.customer:
            return '/user-home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/role-selection',
        name: 'role_selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final role = state.extra as UserRole?;
          return LoginScreen(initialRole: role);
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        name: 'verify_otp',
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: '/set-password',
        name: 'set_password',
        builder: (context, state) => const SetPasswordScreen(),
      ),
      GoRoute(
        path: '/user-home',
        name: 'user_home',
        builder: (context, state) => const UserHomeScreen(),
      ),
      GoRoute(
        path: '/vendor-dashboard',
        name: 'vendor_dashboard',
        builder: (context, state) => const VendorDashboardScreen(),
      ),
      GoRoute(
        path: '/menu-management',
        name: 'menu_management',
        builder: (context, state) => const MenuManagementScreen(),
      ),
      GoRoute(
        path: '/delivery-dashboard',
        name: 'delivery_dashboard',
        builder: (context, state) => const DeliveryDashboardScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        name: 'admin_dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
});
