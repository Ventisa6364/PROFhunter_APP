import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/response_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class ResponsesPage extends GetView<ResponseController> {
  ResponsesPage({super.key});

  final authController = Get.find<AuthController>();
  final vacancyController = Get.find<VacancyController>();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);

    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: 'Отклики',
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
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

        if (controller.responses.isEmpty) {
          return Center(
            child: Text(
              'Откликов пока нет',
              style: CustomStyles.nunitoMedium18.copyWith(
                color: theme.palette.textSecondary,
              ),
            ),
          );
        }

        final responses = controller.responses;

        return RefreshIndicator(
          onRefresh: () => controller.fetchResponse(
            idCandidate: authController.user.value!.id,
          ),
          child: ListView.builder(
            padding: .fromLTRB(16.w, 8.h, 16.w, 16.h),
            itemCount: responses.length,
            itemBuilder: (context, index) {
              final response = responses[index];
              return FutureBuilder<Vacancy>(
                future: vacancyController.getVacancyById(
                  idVacancy: response.idVacancy,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return VacancyLoaderWidget();
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  if (!snapshot.hasData) {
                    return Text('Вакансия не найдена');
                  }

                  final vacancy = snapshot.data!;

                  return Padding(
                    padding: .only(bottom: 12.h),
                    child: VacancyWidget(
                      onTap: () =>
                          Get.toNamed('/vacancy-detail', arguments: vacancy),
                      name: vacancy.name,
                      salary: vacancy.salary,
                      employmentType: vacancy.employmentType,
                      conditions: vacancy.conditions[0],
                      duties: vacancy.duties[0],
                      requirements: vacancy.requirements[0],
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }

  void _getBack() => Get.back();
}
