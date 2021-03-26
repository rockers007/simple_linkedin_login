class UserProfile {
  final String name;
  final String email;
  final String id;
  final String profilePictureUrl;

  UserProfile({
    this.name,
    this.email,
    this.id,
    this.profilePictureUrl,
  });

  @override
  String toString() {
    return 'AppUser{name: $name, email: $email, id: $id, profilePicture: $profilePictureUrl}';
  }
}
