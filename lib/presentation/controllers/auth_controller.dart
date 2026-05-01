import 'package:flutter/cupertino.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/update_profile.dart';

class AuthController extends ChangeNotifier {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  final SignOut signOutUseCase;
  final UpdateUser updateUserUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.updateUserUseCase,
  });

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
    required String role,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await signUpUseCase(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        name: name,
        companyName: companyName,
        selectedRegion: selectedRegion,
        role: role,
      );

      user = await signInUseCase(email: email, password: password);
    } catch (e) {
      error = e.toString();
      rethrow;
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

      user = await signInUseCase(email: email, password: password);
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await signOutUseCase();
    user = null;
    notifyListeners();
  }

  Future<void> updateUser({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await updateUserUseCase(
        id: id,
        email: email,
        name: name,
        companyName: companyName,
        selectedRegion: selectedRegion,
        role: role,
      );

    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool get isLoggedIn => user != null;
}
