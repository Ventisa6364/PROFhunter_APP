import 'package:flutter/cupertino.dart';
import 'package:profhunterapp/auth/app_user.dart';
import 'package:profhunterapp/auth/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository repository;

  AuthController(this.repository);

  bool isLoading = false;
  String? error;
  AppUser? user;

  Future<void> signUp({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await repository.signUp(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        name: name,
        companyName: companyName,
        selectedRegion: selectedRegion,
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await repository.signIn(email: email, password: password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void signOut() {
    repository.signOut();
    user = null;
    notifyListeners();
  }

  bool get isLoggedIn => repository.isLoggedIn;
}
