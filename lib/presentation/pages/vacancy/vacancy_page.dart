import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyPage extends StatelessWidget {
  final VacancyModel vacancy;

  const VacancyPage({super.key, required this.vacancy});

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
                      orgName: vacancy.orgName,
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
                    child: ConditionsList(
                      termsOfEmployment: vacancy.conditions,
                    ),
                  ),
                  ContactsCard(
                    email: vacancy.contacts['email']!,
                    phone: vacancy.contacts['phone']!,
                    textButtonBottomButton: 'Написать работодателю',
                    onPressedBottomButton: () {},
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
