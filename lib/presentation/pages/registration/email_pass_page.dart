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
      appBar: CustomAppBarWidget(
        title: "Создать аккаунт",
        subtitle: "Введите e-mail и пароль",
      ),
      body: Padding(
        padding: .only(
          top: 16.h,
          right: 16.w,
          bottom: 36.h,
          left: 16.w,
        ),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
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
}
