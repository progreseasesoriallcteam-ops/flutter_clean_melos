enum UserRole { admin, user }

extension UserRoleX on UserRole {
  String get value => switch (this) {
        UserRole.admin => 'admin',
        UserRole.user => 'user',
      };

  bool get isAdmin => this == UserRole.admin;
}
