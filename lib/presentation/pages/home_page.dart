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
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 64.h),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 20.h,
            children: [
              Text(
                "Начните работу с приложением",
                style: CustomStyles.nunitoMedium22.copyWith(
                  color: theme.palette.text,
                ),
                textAlign: .center,
              ),
              SizedBox(height: 8.h),
              CustomButton.filled(
                theme: theme,
                onPressed: _getReg,
                text: 'Создать аккаунт',
                height: 48.h,
                width: 336.w,
              ),
              CustomButton.filled(
                theme: theme,
                onPressed: null,
                text: 'Войти в аккаунт',
                height: 48.h,
                width: 336.w,
              ),
              Text(
                'Продолжая, вы соглашаетесь с условиями ',
                style: CustomStyles.nunitoLight14.copyWith(
                  color: theme.palette.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getReg() => Get.to(ChoiceRolePage());
}
