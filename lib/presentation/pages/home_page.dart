import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration/choice_role.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_model.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: theme.palette.block,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Главная",
            style: CustomStyles.nunitoBold32.copyWith(
              color: theme.palette.text,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: .only(top: 12.h, right: 16.w, left: 16.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12.h,
            children: [
              VacancyWidget(
                vacancy: VacancyPython(),
                page: VacancyPage(vacancy: VacancyPython()),
              ),
              VacancyWidget(
                vacancy: VacancyFlutter(),
                page: VacancyPage(vacancy: VacancyFlutter()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getReg() => Get.to(ChoiceRolePage());
}
