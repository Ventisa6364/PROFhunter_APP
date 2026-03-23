import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_model.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyPage extends StatelessWidget {
  const VacancyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: theme.palette.block,
        leading: GestureDetector(
          onTap: _getBack,
          child: Icon(Icons.arrow_back_rounded, color: theme.palette.icon),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Вакансия",
            style: CustomStyles.nunitoBold32.copyWith(
              color: theme.palette.text,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(height: 1.h, thickness: 1.r, color: theme.palette.border),
            VacancyHeroBlock(
              vacancyName: VacancyModel.name,
              textChipsSalary: VacancyModel.salary,
              textChipsEmploymentType: VacancyModel.employmentType,
              textChipsPlace: VacancyModel.place,
            ),
            SizedBox(height: 12.h,),
            Padding(
              padding: .all(16.r),
              child: Column(
                spacing: 16.h,
                children: [
                  InfoCard(title: 'О компании', child: CompanyInfoContent(address: VacancyModel.address, orgName: VacancyModel.orgName,)),
                  InfoCard(
                    title: 'Обязанности',
                    child: BulletList(items: VacancyModel.duties),
                  ),
                  InfoCard(
                    title: 'Требования',
                    child: BulletList(items: VacancyModel.requirements),
                  ),
                  InfoCard(
                    title: 'Условия работы',
                    child: ConditionsList(
                      termsOfEmployment: VacancyModel.conditions,
                    ),
                  ),
                  ContactsCard(
                    email: VacancyModel.contacts['email']!,
                    phone: VacancyModel.contacts['phone']!,
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
