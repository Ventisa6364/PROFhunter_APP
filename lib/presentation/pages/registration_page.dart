import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/auth_page.dart';
import 'package:profhunteruikit/uikit.dart';

class RegPage extends StatelessWidget {
  RegPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: .only(
          top: 18.h,
          right: 20.w,
          bottom: 49.h,
          left: 20.w,
        ).add(MediaQuery.paddingOf(context)),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              spacing: 12.h,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 3.w, left: 2.w),
                  child: Text(
                    "Создать аккаунт",
                    style: CustomStyles.nunitoBold32.copyWith(
                      color: theme.palette.text,
                    ),
                  ),
                ),
                Text(
                  "Создайте аккаунт, чтобы начать",
                  style: CustomStyles.nunitoMedium16.copyWith(
                    color: theme.palette.text,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .stretch,
              spacing: 14.h,
              children: [
                CustomTextInput(emailController, textHint: 'email@example.com', label: 'email',),
                CustomPasswordInput(passwordController: passwordController, label: 'password',),
                CustomPasswordInput(passwordController: passwordConfirmController, label: 'confirm password',),
              ],
            ),
            Column(
              spacing: 28.h,
              children: [
                SizedBox.fromSize(
                  size: .new(336.w, 48.h),
                  child: CustomButton.simple(
                    theme: theme,
                    text: "Войти",
                    onPressed: () {},
                  ),
                ),
                GestureDetector(
                  onTap: _getSignUp,
                  child: Text(
                    "Ещё нет аккаунта?",
                    style: CustomStyles.nunitoRegular12.copyWith(
                      color: theme.palette.text,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getSignUp() => Get.to(AuthPage());
}
