import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunterapp/presentation/pages/vacancy/create_vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<VacancyController>();
  final authController = Get.find<AuthController>();

  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(title: 'Главная'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return VacancyLoaderWidget();
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

        final isCompany = authController.user.value?.role == 'company';

        final vacancies = isCompany
            ? controller.vacanciesCompanyView
            : controller.vacanciesView;

        return Column(
          children: [
            Padding(
              padding: .fromLTRB(16.w, 8.h, 16.w, 12.h),
              child: CustomTextInput.text(
                controller: searchController,
                textHint: 'Поиск по вакансиям',
                onChanged: controller.changeSearchQuery,
              ),
            ),

            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.fetchVacancies,
                child: vacancies.isEmpty
                    ? ListView(
                        children: [
                          SizedBox(height: 160.h),
                          Center(
                            child: Text(
                              'Вакансии не найдены',
                              style: CustomStyles.nunitoMedium18.copyWith(
                                color: theme.palette.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: .fromLTRB(16.w, 0, 16.w, 32.h),
                        itemCount: vacancies.length,
                        itemBuilder: (context, index) {
                          final vacancy = vacancies[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: VacancyWidget(
                              name: vacancy.name,
                              salary: vacancy.salary,
                              employmentType: vacancy.employmentType,
                              conditions: vacancy.conditions.isNotEmpty
                                  ? vacancy.conditions[0]
                                  : '',
                              duties: vacancy.duties.isNotEmpty
                                  ? vacancy.duties[0]
                                  : '',
                              requirements: vacancy.requirements.isNotEmpty
                                  ? vacancy.requirements[0]
                                  : '',
                              onTap: () {
                                Get.toNamed(
                                  '/vacancy-detail',
                                  arguments: vacancy,
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
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
}