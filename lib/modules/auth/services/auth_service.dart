import 'dart:async';
// ignore: unused_import
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/models/user_role.dart';

class AuthService {
  // Use a StreamController to broadcast our mock auth state locally
  final StreamController<UserProfile?> _authStateController = StreamController<UserProfile?>.broadcast();
  UserProfile? _currentUser;

  // Stream of auth state changes
  Stream<UserProfile?> get authStateChanges => _authStateController.stream;

  AuthService() {
    // Push null initially so the app knows we are unauthenticated
    Future.microtask(() => _authStateController.add(null));
  }

  Future<void> sendOtp(String email) async {
    // Mock sending OTP. Wait a bit to simulate network request.
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> verifyOtp(String email, String token, {UserRole? role}) async {
    // Mock verify OTP. 
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> completeSignup(String password, String fullName, UserRole role) async {
    // Mock completing signup and creating a local profile.
    await Future.delayed(const Duration(seconds: 1));
    
    // After signup, we log them out to force a clean login flow, matching the original logic
    _currentUser = null;
    _authStateController.add(null);
  }

  Future<void> login(String email, String password, {UserRole? role}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Create a dummy user profile
    _currentUser = UserProfile(
      id: 'mock-user-id-123',
      email: email,
      fullName: 'Test User',
      role: role ?? UserRole.user,
    );
    
    // Broadcast the new authenticated state
    _authStateController.add(_currentUser);
  }

  Future<void> logout() async {
    _currentUser = null;
    _authStateController.add(null);
  }
  
  Future<void> signOut() async => logout();
}

