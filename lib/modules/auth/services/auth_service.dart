import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/models/user_role.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Stream of auth state changes (strictly following Supabase session + database profile)
  Stream<UserProfile?> get authStateChanges {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      final user = event.session?.user;
      if (user == null) return null;

      try {
        final profileData = await _client
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (profileData != null) {
          return UserProfile.fromJson({
            ...profileData,
            'email': user.email ?? '',
          });
        }
        
        // If no profile exists in DB, it's a new user during signup flow
        return UserProfile(
          id: user.id,
          email: user.email ?? '',
          fullName: 'New User',
          role: UserRole.user,
          isPlaceholder: true, // Crucial for router to know we're not finished
        );
      } catch (e) {
        return null;
      }
    });
  }

  Future<void> sendOtp(String email) async {
    // Only Email OTP is supported now
    await _client.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp(String email, String token, {UserRole? role}) async {
    await _client.auth.verifyOTP(
      token: token,
      type: OtpType.signup, // Standard for registration verification
      email: email,
    );
  }

  Future<void> completeSignup(String password, String fullName, UserRole role) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('Session expired. Please start over.');

    try {
      // 1. Update password
      await _client.auth.updateUser(UserAttributes(password: password));
      
      // 2. Create profile in database
      final response = await _client.from('profiles').upsert({
        'id': user.id,
        'name': fullName,
        'role': role.name,
        'email': user.email,
      }).select();

      if (response == null) {
        throw Exception('Database error: Failed to save your profile.');
      }

      // 3. Clear data and sign out for a clean login
      await signOut();
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } on PostgrestException catch (e) {
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> login(String email, String password, {UserRole? role}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async => await _client.auth.signOut();
  Future<void> signOut() async => await _client.auth.signOut();
}

