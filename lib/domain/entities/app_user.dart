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
}