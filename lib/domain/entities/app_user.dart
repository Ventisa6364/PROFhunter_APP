class AppUser {
  final String id;
  final String email;
  final String name;
  final String companyName;
  final String selectedRegion;
  final String role;
  final String avatar;
  final String aboutMyself;
  final String aboutCompany;
  final List<String> skills;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.companyName,
    required this.selectedRegion,
    required this.role,
    required this.avatar,
    required this.aboutMyself,
    required this.aboutCompany,
    required this.skills,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    String? companyName,
    String? selectedRegion,
    String? role,
    String? avatar,
    String? aboutMyself,
    String? aboutCompany,
    List<String>? skills,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      aboutMyself: aboutMyself ?? this.aboutMyself,
      aboutCompany: aboutCompany ?? this.aboutCompany,
      skills: skills ?? this.skills,
    );
  }
}
