import 'package:profhunterapp/domain/entities/app_user.dart';

abstract class AuthRepository {

  Future<AppUser> signUp({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
  });

  Future<AppUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<AppUser> updateUser({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
    required String avatar,
    required String aboutMyself,
    required String aboutCompany,
    required List<String> skills,
  });

  AppUser? get currentUser;

  bool get isLoggedIn;
}