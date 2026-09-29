class User {
  final String name;
  final String role;
  final String phoneNumber;
  final String email;
  final String department;
  final String? profileImageUrl; // URL ou chemin vers l’image, null si aucune

  User({
    required this.name,
    required this.role,
    required this.phoneNumber,
    required this.email,
    required this.department,
    this.profileImageUrl,
  });

  /// Crée un User à partir d’un JSON (ex. réponse d’API)
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        role: json['role'] as String,
        phoneNumber: json['phone_number'] as String,
        email: json['email'] as String,
        department: json['department'] as String,
        profileImageUrl: json['profile_image_url'] as String?,
      );

  /// Convertit ce User en JSON (pour envoi à l’API)
  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'phone_number': phoneNumber,
        'email': email,
        'department': department,
        if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      };

  /// Permet de copier et modifier quelques champs
  User copyWith({
    String? name,
    String? role,
    String? phoneNumber,
    String? email,
    String? department,
    String? profileImageUrl,
  }) {
    return User(
      name: name ?? this.name,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      department: department ?? this.department,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
