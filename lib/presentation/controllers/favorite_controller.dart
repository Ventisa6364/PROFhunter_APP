import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/favorite.dart';
import 'package:profhunterapp/domain/entities/favorite_view_data.dart';
import 'package:profhunterapp/domain/usecases/favorite/add_favorite.dart';
import 'package:profhunterapp/domain/usecases/favorite/delete_favorite.dart';
import 'package:profhunterapp/domain/usecases/favorite/get_user_favorite.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class FavoriteController extends GetxController {
  final AddFavorite addFavoriteUseCase;
  final DeleteFavorite deleteFavoriteUseCase;
  final GetUserFavorite getUserFavoritesUseCase;

  FavoriteController({
    required this.addFavoriteUseCase,
    required this.deleteFavoriteUseCase,
    required this.getUserFavoritesUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<Favorite> favorites = <Favorite>[].obs;
  final RxList<FavoriteViewData> favoritesViewData = <FavoriteViewData>[].obs;

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    if (authController.user.value?.id.isNotEmpty == true) {
      fetchFavorites(userID: authController.user.value!.id);
    }
  }

  Future<void> addFavorite({
    required String idUser,
    required String idVacancy,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await addFavoriteUseCase(
        user: idUser,
        vacancy: idVacancy,
      );

      await fetchFavorites(userID: idUser);

      final context = Get.context;

      if (context != null) {
        final theme = CustomTheme.of(context);

        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Добавлено',
            style: CustomStyles.nunitoMedium22.copyWith(
              color: theme.palette.text,
            ),
          ),
          messageText: Text(
            'Вакансия добавлена в избранное',
            style: CustomStyles.nunitoMedium16.copyWith(
              color: theme.palette.textSecondary,
            ),
          ),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');

      _showErrorSnackbar(errorMessage.value);

      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFavorite({
    required String idFavorite,
    required String userID,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await deleteFavoriteUseCase(id: idFavorite);

      await fetchFavorites(userID: userID);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');

      _showErrorSnackbar(errorMessage.value);

      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFavorites({
    required String userID,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getUserFavoritesUseCase(
        user: userID,
      );

      favoritesViewData.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(String idVacancy) {
    return favoritesViewData.any(
          (favorite) => favorite.vacancy.id == idVacancy,
    );
  }

  FavoriteViewData? getFavoriteByVacancyId(String idVacancy) {
    try {
      return favoritesViewData.firstWhere(
            (favorite) => favorite.vacancy.id == idVacancy,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> toggleFavorite({
    required String userID,
    required String idVacancy,
  }) async {
    final favorite = getFavoriteByVacancyId(idVacancy);

    if (favorite == null) {
      await addFavorite(
        idUser: userID,
        idVacancy: idVacancy,
      );
    } else {
      await deleteFavorite(
        idFavorite: favorite.favorite.id,
        userID: userID,
      );
    }
  }

  void clearAll() {
    favorites.clear();
    favoritesViewData.clear();
    errorMessage.value = '';
    isLoading.value = false;
  }

  void _showErrorSnackbar(String message) {
    final context = Get.context;

    if (context == null) return;

    final theme = CustomTheme.of(context);

    Get.snackbar(
      '',
      '',
      titleText: Text(
        'Ошибка',
        style: CustomStyles.nunitoMedium22.copyWith(
          color: theme.palette.text,
        ),
      ),
      messageText: Text(
        message,
        style: CustomStyles.nunitoMedium16.copyWith(
          color: theme.palette.textSecondary,
        ),
      ),
    );
  }
}