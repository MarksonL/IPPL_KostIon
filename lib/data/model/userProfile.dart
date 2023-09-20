class UserProfile {
  final String name;
  final String email;
  final UserType userType;

  UserProfile({
    required this.name,
    required this.email,
    required this.userType,
  });
}

enum UserType { tenant, owner, admin }
