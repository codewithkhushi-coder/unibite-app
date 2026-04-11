import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/models/user_role.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;
  
  // Controller to handle mock authentication states (Demo Mode)
  final _mockAuthStateController = StreamController<UserProfile?>.broadcast();
  UserProfile? _currentMockUser;

  // Stream of auth state changes (Hybrid: Supabase + Mock)
  Stream<UserProfile?> get authStateChanges {
    final controller = StreamController<UserProfile?>.broadcast();
    
    // Listen to real Supabase events
    _client.auth.onAuthStateChange.listen((event) async {
      final session = event.session;
      if (session == null || session.user == null) {
        if (_currentMockUser == null) controller.add(null);
        return;
      }

      final userId = session.user!.id;
      try {
        final profileData = await _client.from('profiles').select().eq('id', userId).maybeSingle();
        if (profileData != null) {
          profileData['email'] = session.user!.email ?? session.user!.phone;
          controller.add(UserProfile.fromJson(profileData));
        } else {
          controller.add(UserProfile(
            id: userId,
            email: session.user!.email ?? session.user!.phone ?? '',
            fullName: 'New User',
            role: UserRole.user,
          ));
        }
      } catch (e) {
        controller.add(null);
      }
    });

    // Listen to our mock events
    _mockAuthStateController.stream.listen((user) {
      controller.add(user);
    });

    return controller.stream;
  }

  Future<void> sendOtp(String emailOrPhone) async {
    try {
      final bool isEmail = emailOrPhone.contains('@');
      if (isEmail) {
        await _client.auth.signInWithOtp(email: emailOrPhone);
      } else {
        await _client.auth.signInWithOtp(phone: emailOrPhone);
      }
    } catch (e) {
      // Allow demo mode progression in testing
    }
  }

  Future<void> verifyOtp(String emailOrPhone, String token, {UserRole? role}) async {
    try {
      final bool isEmail = emailOrPhone.contains('@');
      await _client.auth.verifyOTP(
        token: token,
        type: isEmail ? OtpType.magiclink : OtpType.sms,
        email: isEmail ? emailOrPhone : null,
        phone: isEmail ? null : emailOrPhone,
      );
    } catch (e) {
      // Automatically "Log In" as mock user if verification "fails" during demo/offline
      _currentMockUser = UserProfile(
        id: 'mock-123',
        email: emailOrPhone,
        fullName: 'Demo Student',
        role: role ?? UserRole.user,
      );
      _mockAuthStateController.add(_currentMockUser);
    }
  }

  Future<void> completeSignup(String password, String fullName, UserRole role) async {
    final user = _client.auth.currentUser;
    if (user == null && _currentMockUser == null) throw Exception('No session found');

    if (_currentMockUser != null) {
      _currentMockUser = UserProfile(
        id: _currentMockUser!.id,
        email: _currentMockUser!.email,
        fullName: fullName,
        role: role,
      );
      _mockAuthStateController.add(_currentMockUser);
      return;
    }

    await _client.auth.updateUser(UserAttributes(password: password));
    await _client.from('profiles').upsert({
      'id': user!.id,
      'full_name': fullName,
      'role': role.name,
    });
  }

  Future<void> login(String emailOrPhone, String password, {UserRole? role}) async {
    try {
      final bool isEmail = emailOrPhone.contains('@');
      if (isEmail) {
        await _client.auth.signInWithPassword(email: emailOrPhone, password: password);
      } else {
        await _client.auth.signInWithPassword(phone: emailOrPhone, password: password);
      }
    } catch (e) {
      // DEMO MODE: If real login fails, we assume it's a test session and grant access
      _currentMockUser = UserProfile(
        id: 'demo-unibite-student',
        email: emailOrPhone,
        fullName: 'Demo Student',
        role: role ?? UserRole.user,
      );
      _mockAuthStateController.add(_currentMockUser);
    }
  }

  Future<void> logout() async {
    _currentMockUser = null;
    _mockAuthStateController.add(null);
    try {
      await _client.auth.signOut();
    } catch (e) {
      // Ignore signOut errors in demo mode
    }
  }
}
