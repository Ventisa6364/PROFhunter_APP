import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/auth/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/auth_page.dart';
import 'package:profhunterapp/presentation/pages/profile.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_model.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
import 'package:profhunteruikit/uikit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16.w,
        scrolledUnderElevation: 0,
        backgroundColor: theme.palette.block,
        title: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              "Главная",
              style: CustomStyles.nunitoBold32.copyWith(
                color: theme.palette.text,
              ),
            ),
            GestureDetector(
              onTap: _getProfile,
              child: Icon(
                Icons.person_outlined,
                color: theme.palette.icon,
                size: 32.sp,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: .only(right: 16.w, left: 16.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12.h,
            children: [
              SizedBox(),
              VacancyWidget(
                vacancy: VacancyPython(),
                page: VacancyPage(vacancy: VacancyPython()),
              ),
              VacancyWidget(
                vacancy: VacancyFlutter(),
                page: VacancyPage(vacancy: VacancyFlutter()),
              ),
              VacancyWidget(
                vacancy: VacancyBackend(),
                page: VacancyPage(vacancy: VacancyBackend()),
              ),
              VacancyWidget(
                vacancy: VacancyUIUX(),
                page: VacancyPage(vacancy: VacancyUIUX()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getProfile() => (controller.isLoggedIn)
      ? {Get.to(() => ProfileScreen())}
      : {Get.to(() => AuthPage())};
}
