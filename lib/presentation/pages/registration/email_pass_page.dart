import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration/registration_page_candidate.dart';
import 'package:profhunterapp/presentation/pages/registration/registration_page_company.dart';
import 'package:profhunteruikit/uikit.dart';

class EmailAndPassPage extends StatefulWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  EmailAndPassPage({super.key});

  @override
  State<EmailAndPassPage> createState() => _EmailAndPassPageState();
}

class _EmailAndPassPageState extends State<EmailAndPassPage> {
  final role = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: .only(
          top: 20.h,
          right: 15.w,
          bottom: 30.h,
          left: 15.w,
        ).add(MediaQuery.paddingOf(context)),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _getBack,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: theme.palette.icon,
                      ),
                    ),
                    Column(
                      spacing: 12.h,
                      crossAxisAlignment: .end,
                      mainAxisAlignment: .end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 3.w, left: 2.w),
                          child: Text(
                            "Создать аккаунт",
                            style: CustomStyles.nunitoBold28.copyWith(
                              color: theme.palette.text,
                            ),
                          ),
                        ),
                        Text(
                          "Введите e-mail и придумайте пароль",
                          style: CustomStyles.nunitoMedium16.copyWith(
                            color: theme.palette.text,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .stretch,
                  spacing: 5.h,
                  children: [
                    CustomTextInput(
                      controller: widget.emailController,
                      textHint: 'email@example.com',
                      label: 'E-mail',
                    ),
                    CustomPasswordInput(
                      controller: widget.passwordController,
                      label: 'Пароль',
                      textHint: 'Password',
                    ),
                    CustomPasswordInput(
                      controller: widget.passwordConfirmController,
                      label: 'Повторите пароль',
                      textHint: ' Confirm password',
                    ),
                  ],
                ),
              ],
            ),
            Column(
              spacing: 15.h,
              children: [
                CustomButton.filled(
                  theme: theme,
                  text: "Продолжить",
                  onPressed: () {
                    if (role == 'candidate') {
                      Get.to(RegistrationCandidatePage());
                    } else if (role == 'company') {
                      Get.to(RegistrationCompanyPage());
                    }
                  },
                  height: 48.h,
                  width: 336.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getBack() => Get.back();
}
