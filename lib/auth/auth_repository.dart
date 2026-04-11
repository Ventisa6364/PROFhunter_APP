import 'package:profhunterapp/auth/app_user.dart';

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

  void signOut();

  AppUser? get currentUser;

  bool get isLoggedIn;
}