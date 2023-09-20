class UserProfile {
  final String name;
  final String email;
  final UserType userType;
  bool isBlocked;

  UserProfile({
    required this.name,
    required this.email,
    required this.userType,
    this.isBlocked = false,
  });
}

enum UserType { tenant, owner, admin }
