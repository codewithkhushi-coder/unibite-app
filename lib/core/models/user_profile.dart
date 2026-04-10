import 'package:equatable/equatable.dart';
import 'user_role.dart';

class UserProfile extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final UserRole role;

  const UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String? ?? 'Unknown User',
      role: UserRoleExtension.fromString(json['role'] as String? ?? 'user'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role.name,
    };
  }

  @override
  List<Object?> get props => [id, email, fullName, role];
}
