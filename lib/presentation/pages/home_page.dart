import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunterapp/presentation/pages/auth_page.dart';
import 'package:profhunterapp/presentation/pages/profile/profile.dart';
import 'package:profhunterapp/presentation/pages/vacancy/create_vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class HomePage extends GetView<VacancyController> {
  HomePage({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Главная',
        iconBtn: Icons.person_outlined,
        onPressed: _getProfile,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              'Ошибка загрузки: ${controller.errorMessage.value}',
              textAlign: TextAlign.center,
              style: CustomStyles.nunitoMedium18.copyWith(
                color: theme.palette.textSecondary,
              ),
            ),
          );
        }

        if (controller.vacancies.isEmpty) {
          return Center(
            child: Text(
              'Вакансий пока нет',
              style: CustomStyles.nunitoMedium18.copyWith(
                color: theme.palette.textSecondary,
              ),
            ),
          );
        }

        final vacancies = controller.vacancies;
        if (authController.user.value?.role == 'company') {
          return RefreshIndicator(
            onRefresh: controller.fetchVacancies,
            child: ListView.builder(
              padding: .all(16.r),
              itemCount: controller.vacanciesCompany.length,
              itemBuilder: (context, index) {
                final vacancy = controller.vacanciesCompany[index];

                return Padding(
                  padding: .only(bottom: 12.h),
                  child: VacancyWidget(
                    name: vacancy.name,
                    salary: vacancy.salary,
                    employmentType: vacancy.employmentType,
                    conditions: vacancy.conditions[0],
                    duties: vacancy.duties[0],
                    requirements: vacancy.requirements[0],
                    onTap: () =>
                        Get.toNamed('/vacancy-detail', arguments: vacancy),
                  ),
                );
              },
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.fetchVacancies,
          child: ListView.builder(
            padding: .all(16.r),
            itemCount: vacancies.length,
            itemBuilder: (context, index) {
              final vacancy = vacancies[index];

              return Padding(
                padding: .only(bottom: 12.h),
                child: VacancyWidget(
                  name: vacancy.name,
                  salary: vacancy.salary,
                  employmentType: vacancy.employmentType,
                  conditions: vacancy.conditions[0],
                  duties: vacancy.duties[0],
                  requirements: vacancy.requirements[0],
                  onTap: () =>
                      Get.toNamed('/vacancy-detail', arguments: vacancy),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (authController.user.value?.role == 'company') {
          return FloatingActionButton(
            onPressed: () {
              Get.to(() => CreateVacancyPage());
            },
            backgroundColor: theme.palette.block,
            elevation: 3,
            child: Icon(Icons.add, color: theme.palette.icon, size: 24.sp),
          );
        }
        return SizedBox(width: 0.w, height: 0.h);
      }),
    );
  }

  void _getProfile() {
    if (authController.isLoggedIn) {
      Get.to(() => ProfileScreen());
    } else {
      Get.to(() => AuthPage());
    }
  }
}
