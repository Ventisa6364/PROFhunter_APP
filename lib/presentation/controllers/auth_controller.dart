import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/usecases/get_user_by_id.dart';
import 'package:profhunterapp/domain/usecases/restore_current_user.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/update_user.dart';

class AuthController extends GetxController {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  final SignOut signOutUseCase;
  final UpdateUser updateUserUseCase;
  final RestoreCurrentUser restoreCurrentUserUseCase;
  final GetUserById getUserByIdUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.updateUserUseCase,
    required this.restoreCurrentUserUseCase,
    required this.getUserByIdUseCase,
  }) {
    restoreCurrentUser();
  }

  final isLoading = false.obs;
  final error = RxnString();
  final user = Rxn<AppUser>();

  bool get isLoggedIn => user.value != null;

  @override
  void onInit() {
    super.onInit();
    restoreCurrentUser();
  }

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
      isLoading.value = true;
      error.value = null;

      await signUpUseCase(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        name: name,
        companyName: companyName,
        selectedRegion: selectedRegion,
        role: role,
      );

      user.value = await signInUseCase(email: email, password: password);
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      isLoading.value = true;
      error.value = null;

      user.value = await signInUseCase(email: email, password: password);
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await signOutUseCase();
    user.value = null;
  }

  Future<void> updateUser({
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
  }) async {
    try {
      isLoading.value = true;
      error.value = null;

      user.value = await updateUserUseCase(
        id: id,
        email: email,
        name: name,
        companyName: companyName,
        selectedRegion: selectedRegion,
        role: role,
        avatar: avatar,
        aboutMyself: aboutMyself,
        aboutCompany: aboutCompany,
        skills: skills,
      );
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> restoreCurrentUser() async {
    try {
      isLoading.value = true;
      error.value = null;

      user.value = await restoreCurrentUserUseCase();
    } finally {
      isLoading.value = false;
    }
  }

  Future<AppUser> getUserById({required String userID}) async {
    return await getUserByIdUseCase(userID: userID);
  }
}
