import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration_page.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 64.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 32.h,
            children: [
              CustomButton.filled(
                theme: theme,
                onPressed: () {},
                text: 'Войти',
                height: 48.h,
                width: 336.w,
              ),
              CustomButton.filled(
                theme: theme,
                onPressed: null,
                text: 'Войти',
                height: 48.h,
                width: 336.w,
              ),
              CustomButton.error(
                theme: theme,
                onPressed: () {},
                text: 'Войти',
                height: 48.h,
                width: 336.w,
              ),
              CustomButton.simple(
                theme: theme,
                onPressed: () {},
                text: 'Войти',
                height: 48.h,
                width: 336.w,
              ),
              CustomButton.filled(
                theme: theme,
                onPressed: _getReg,
                text: 'auth page',
                height: 48.h,
                width: 336.w,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getReg() => Get.to(RegistrationPage());
}
