import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/usecases/add_resume.dart';
import 'package:profhunterapp/domain/usecases/delete_avatar.dart';
import 'package:profhunterapp/domain/usecases/delete_resume.dart';
import 'package:profhunterapp/domain/usecases/get_user_by_id.dart';
import 'package:profhunterapp/domain/usecases/restore_current_user.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/update_avatar.dart';
import 'package:profhunterapp/domain/usecases/update_user.dart';

class AuthController extends GetxController {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  final SignOut signOutUseCase;
  final UpdateUser updateUserUseCase;
  final RestoreCurrentUser restoreCurrentUserUseCase;
  final GetUserById getUserByIdUseCase;
  final UpdateAvatar updateAvatarUseCase;
  final DeleteAvatar deleteAvatarUseCase;
  final AddResume addResumeUseCase;
  final DeleteResume deleteResumeUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.updateUserUseCase,
    required this.restoreCurrentUserUseCase,
    required this.getUserByIdUseCase,
    required this.updateAvatarUseCase,
    required this.deleteAvatarUseCase,
    required this.addResumeUseCase,
    required this.deleteResumeUseCase,
  }) {
    restoreCurrentUser();
  }

  final isLoading = false.obs;
  final error = RxnString();
  final user = Rxn<AppUser>();
  final selectedResumeName = ''.obs;

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

  Future<AppUser> updateAvatar({
    required String userID,
    required String imagePath,
  }) async {
    final currentUser = user.value;

    if (currentUser == null) {
      throw Exception('User is null');
    }

    try {
      user.value = currentUser.copyWith(avatar: '');

      final updatedUser = await updateAvatarUseCase(
        userID: userID,
        imagePath: imagePath,
      );

      user.value = updatedUser;

      return updatedUser;
    } catch (e) {
      user.value = currentUser;
      rethrow;
    }
  }

  Future<void> deleteAvatar() async {
    if (user.value == null) return;

    await deleteAvatarUseCase(userID: user.value!.id);

    user.value = user.value!.copyWith(avatar: '');
  }

  Future<void> pickAndUploadResume() async {
    final currentUser = user.value;

    if (currentUser == null) {
      Get.snackbar(
        'Ошибка',
        'Пользователь не найден',
      );
      return;
    }

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.single;

      final filePath = file.path;
      final fileName = file.name;
      final extension = file.extension?.toLowerCase();

      if (filePath == null || filePath.isEmpty) {
        Get.snackbar(
          'Ошибка',
          'Не удалось получить путь к файлу',
        );
        return;
      }

      if (extension == null ||
          !['pdf', 'doc', 'docx'].contains(extension)) {
        Get.snackbar(
          'Ошибка',
          'Можно загрузить только PDF, DOC или DOCX',
        );
        return;
      }

      isLoading.value = true;

      final updatedUser = await addResumeUseCase(
        userID: currentUser.id,
        filePath: filePath,
      );

      user.value = updatedUser;
      selectedResumeName.value = fileName;

      Get.snackbar(
        'Готово',
        'Резюме успешно загружено',
      );
    } catch (e) {
      Get.snackbar(
        'Ошибка',
        'Не удалось загрузить резюме',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteResume() async {
    final currentUser = user.value;

    if (currentUser == null) {
      Get.snackbar(
        'Ошибка',
        'Пользователь не найден',
      );
      return;
    }

    try {
      isLoading.value = true;

      await deleteResumeUseCase(
        userID: currentUser.id,
      );

      user.value = currentUser.copyWith(
        resume: '',
      );

      selectedResumeName.value = '';

      Get.snackbar(
        'Готово',
        'Резюме удалено',
      );
    } catch (e) {
      Get.snackbar(
        'Ошибка',
        'Не удалось удалить резюме',
      );
    } finally {
      isLoading.value = false;
    }
  }

}
