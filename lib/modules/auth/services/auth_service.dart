import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/models/user_role.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Stream of auth state changes mapped to custom UserProfile
  Stream<UserProfile?> get authStateChanges {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      final session = event.session;
      if (session == null || session.user == null) {
        return null;
      }

      final userId = session.user!.id;
      
      try {
        final profileData = await _client
            .from('profiles')
            .select()
            .eq('id', userId)
            .maybeSingle();

        if (profileData != null) {
          // Provide email/phone from auth session explicitly
          profileData['email'] = session.user!.email ?? session.user!.phone; 
          return UserProfile.fromJson(profileData);
        }
      } catch (e) {
        // Fallback or error logging
      }
      
      // Fallback Profile if database read fails
      return UserProfile(
        id: userId,
        email: session.user!.email ?? session.user!.phone ?? '',
        fullName: 'New User',
        role: UserRole.user,
      );
    });
  }

  Future<void> sendOtp(String emailOrPhone) async {
    final bool isEmail = emailOrPhone.contains('@');
    if (isEmail) {
      await _client.auth.signInWithOtp(email: emailOrPhone);
    } else {
      await _client.auth.signInWithOtp(phone: emailOrPhone);
    }
  }

  Future<void> verifyOtp(String emailOrPhone, String token) async {
    final bool isEmail = emailOrPhone.contains('@');
    await _client.auth.verifyOTP(
      token: token,
      type: isEmail ? OtpType.magiclink : OtpType.sms,
      email: isEmail ? emailOrPhone : null,
      phone: isEmail ? null : emailOrPhone,
    );
  }

  Future<void> completeSignup(String password, String fullName, UserRole role) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No authenticated user found');

    // Update password
    await _client.auth.updateUser(UserAttributes(password: password));

    // Save profile
    await _client.from('profiles').upsert({
      'id': user.id,
      'full_name': fullName,
      'role': role.name,
    });
  }

  Future<void> login(String emailOrPhone, String password) async {
    final bool isEmail = emailOrPhone.contains('@');
    if (isEmail) {
      await _client.auth.signInWithPassword(email: emailOrPhone, password: password);
    } else {
      await _client.auth.signInWithPassword(phone: emailOrPhone, password: password);
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
