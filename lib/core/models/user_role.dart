enum UserRole {
  user,
  vendor,
  delivery,
  admin,
  customer
}

extension UserRoleExtension on UserRole {
  String get name => toString().split('.').last;

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'vendor':
      case 'restaurant':
        return UserRole.vendor;
      case 'delivery':
        return UserRole.delivery;
      case 'admin':
        return UserRole.admin;
      case 'customer':
        return UserRole.customer;
      case 'user':
      default:
        return UserRole.user;
    }
  }
}
