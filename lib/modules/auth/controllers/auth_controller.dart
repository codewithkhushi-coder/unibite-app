import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_profile.dart';
import '../../../core/models/user_role.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// For tracking signup progress across screens
class SignupData {
  final String? emailOrPhone;
  final UserRole? role;
  final String? fullName;

  SignupData({this.emailOrPhone, this.role, this.fullName});

  SignupData copyWith({String? emailOrPhone, UserRole? role, String? fullName}) {
    return SignupData(
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
    );
  }
}

final signupDataProvider = StateProvider<SignupData>((ref) => SignupData());

// Provider to track selected role from Role Selection screen
final selectedRoleProvider = StateProvider<UserRole>((ref) => UserRole.user);

class AuthController extends Notifier<UserProfile?> {
  @override
  UserProfile? build() {
    // We bind to the auth stream to instantly synchronize local app state with the backend
    ref.watch(authServiceProvider).authStateChanges.listen((profile) {
      state = profile;
    });
    
    return null; // Begins conceptually unauthenticated
  }

  Future<void> sendOtp(String emailOrPhone) async {
    await ref.read(authServiceProvider).sendOtp(emailOrPhone);
    ref.read(signupDataProvider.notifier).update((s) => s.copyWith(emailOrPhone: emailOrPhone));
  }

  Future<void> verifyOtp(String token) async {
    final emailOrPhone = ref.read(signupDataProvider).emailOrPhone;
    final role = ref.read(selectedRoleProvider);
    if (emailOrPhone == null) throw Exception('Email or Phone not set');
    await ref.read(authServiceProvider).verifyOtp(emailOrPhone, token, role: role);
  }

  Future<void> completeSignup(String password, String fullName, UserRole role) async {
    await ref.read(authServiceProvider).completeSignup(password, fullName, role);
  }

  Future<void> login(String emailOrPhone, String password, {UserRole? role}) async {
    await ref.read(authServiceProvider).login(emailOrPhone, password, role: role);
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
  }
}

final authControllerProvider = NotifierProvider<AuthController, UserProfile?>(AuthController.new);
