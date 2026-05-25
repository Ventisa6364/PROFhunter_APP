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

  Future<AppUser> signIn({required String email, required String password});

  Future<void> signOut();

  Future<AppUser> updateUser({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
    required String aboutMyself,
    required String aboutCompany,
    required List<String> skills,
  });

  Future<AppUser> getUserById({required String userID});

  Future<AppUser> updateAvatar({
    required String userID,
    required String imagePath,
  });

  Future<AppUser> deleteAvatar({required String userID});

  AppUser? get currentUser;

  bool get isLoggedIn;

  Future<AppUser?> restoreCurrentUser();
}
