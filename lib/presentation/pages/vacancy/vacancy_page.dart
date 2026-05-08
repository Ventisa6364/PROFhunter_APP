import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyPage extends StatelessWidget {
  final Vacancy vacancy;

  final authController = Get.find<AuthController>();

  VacancyPage({super.key, required this.vacancy});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Вакансия',
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1.h, thickness: 1.r, color: theme.palette.border),
            VacancyHeroBlock(
              vacancyName: vacancy.name,
              textChipsSalary: vacancy.salary,
              textChipsEmploymentType: vacancy.employmentType,
              textChipsPlace: vacancy.place,
              isCandidate: (authController.user.value?.role == 'candidate')
                  ? true
                  : false,
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: .all(16.r),
              child: Column(
                spacing: 16.h,
                children: [
                  InfoCard(
                    title: 'О компании',
                    child: CompanyInfoContent(
                      address: vacancy.address,
                      orgName: vacancy.companyName,
                    ),
                  ),
                  InfoCard(
                    title: 'Обязанности',
                    child: BulletList(items: vacancy.duties),
                  ),
                  InfoCard(
                    title: 'Требования',
                    child: BulletList(items: vacancy.requirements),
                  ),
                  InfoCard(
                    title: 'Условия работы',
                    child: BulletList(
                      items: vacancy.conditions,
                    ),
                  ),
                  ContactsCard(
                    email: vacancy.contacts['email']!,
                    phone: vacancy.contacts['phone']!,
                    textBottomButton:
                        (authController.user.value?.role == 'candidate')
                        ? 'Написать работодателю'
                        : null,
                    onPressedBottomButton:
                        (authController.user.value?.role == 'candidate')
                        ? () {}
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getBack() => Get.back();
}
