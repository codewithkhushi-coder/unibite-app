import 'package:equatable/equatable.dart';
import 'user_role.dart';

class UserProfile extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final UserRole role;
  final String? canteenId;
  final bool isPlaceholder;

  const UserProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.canteenId,
    this.isPlaceholder = false,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String? ?? json['name'] ?? 'Unknown User',
      role: UserRoleExtension.fromString(json['role'] as String? ?? 'user'),
      canteenId: json['canteen_id']?.toString(),
      isPlaceholder: false, // Profiles from JSON are assumed to be from database
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role.name,
      'canteen_id': canteenId,
    };
  }

  @override
  List<Object?> get props => [id, email, fullName, role, canteenId, isPlaceholder];
}
