import 'package:profhunterapp/domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.companyName,
    required super.selectedRegion,
    required super.role,
    required super.avatar,
    required super.resume,
    required super.aboutMyself,
    required super.aboutCompany,
    required super.skills,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      companyName: map['companyName'] as String? ?? '',
      selectedRegion: map['selectedRegion'] as String? ?? '',
      role: map['role'] as String? ?? '',
      avatar: map['avatar'] as String? ?? '',
      resume: map['resume'] as String? ?? '',
      aboutMyself: map['aboutMyself'] as String? ?? '',
      aboutCompany: map['aboutCompany'] as String? ?? '',
      skills: (map['skills'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}