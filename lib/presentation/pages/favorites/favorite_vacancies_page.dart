import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/favorite_controller.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class FavoriteVacanciesPage extends StatefulWidget {
  const FavoriteVacanciesPage({super.key});

  @override
  State<FavoriteVacanciesPage> createState() => _FavoriteVacanciesPageState();
}

class _FavoriteVacanciesPageState extends State<FavoriteVacanciesPage> {
  final favoriteController = Get.find<FavoriteController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = authController.user.value;

      if (user != null) {
        favoriteController.fetchFavorites(userID: user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.of(context);

    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: 'Избранное',
        iconBtn: Icons.close,
        onPressed: _close,
      ),
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final user = authController.user.value;

                if (user == null) {
                  return Center(
                    child: Text(
                      'Войдите в аккаунт',
                      style: CustomStyles.nunitoMedium16.copyWith(
                        color: theme.palette.textSecondary,
                      ),
                    ),
                  );
                }

                if (favoriteController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (favoriteController.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        favoriteController.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: CustomStyles.nunitoMedium16.copyWith(
                          color: theme.palette.textSecondary,
                        ),
                      ),
                    ),
                  );
                }

                if (favoriteController.favoritesViewData.isEmpty) {
                  return EmptyFavoritesWidget(theme: theme);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await favoriteController.fetchFavorites(userID: user.id);
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                    itemCount: favoriteController.favoritesViewData.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = favoriteController.favoritesViewData[index];
                      final vacancy = item.vacancy;

                      return FavoriteVacancyCard(
                        vacancyName: vacancy.name,
                        salary: vacancy.salary,
                        employmentType: vacancy.employmentType,
                        place: vacancy.place,
                        companyName: vacancy.companyName,
                        theme: theme,
                        onTap: () {
                          Get.to(() => VacancyPage(vacancy: vacancy));
                        },
                        onFavoriteTap: () async {
                          await favoriteController.toggleFavorite(
                            userID: user.id,
                            idVacancy: vacancy.id,
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _close() => Get.back();
}

