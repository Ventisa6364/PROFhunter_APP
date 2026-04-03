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
  final _formKey = GlobalKey<FormState>();

  EmailAndPassPage({super.key});

  @override
  State<EmailAndPassPage> createState() => _EmailAndPassPageState();
}

class _EmailAndPassPageState extends State<EmailAndPassPage> {
  final role = Get.arguments;
  final emailKey = GlobalKey<CustomTextInputState>();
  final passwordKey = GlobalKey<CustomPasswordInputState>();
  final confirmPasswordKey = GlobalKey<CustomPasswordInputState>();

  late var isEmailValid = emailKey.currentState?.validate() ?? false;
  late var isPasswordValid = passwordKey.currentState?.validate() ?? false;
  late var isConfirmPasswordValid =
      confirmPasswordKey.currentState?.validate() ?? false;

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
        padding: .fromLTRB(16.h, 16.w, 16.w, 36.h),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                Form(
                  key: widget._formKey,
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .stretch,
                    spacing: 5.h,
                    children: [
                      CustomTextInput.email(
                        key: emailKey,
                        controller: widget.emailController,
                        textHint: 'email@example.com',
                        label: 'E-mail',
                        onChanged: (_) => _updateFormValidity(),
                      ),
                      CustomPasswordInput(
                        key: passwordKey,
                        controller: widget.passwordController,
                        label: 'Пароль',
                        textHint: 'Password',
                        onChanged: (_) => _updateFormValidity(),
                      ),
                      CustomPasswordInput(
                        key: confirmPasswordKey,
                        controller: widget.passwordConfirmController,
                        label: 'Повторите пароль',
                        textHint: ' Confirm password',
                        onChanged: (_) => _updateFormValidity(),
                        confirmController: widget.passwordController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              spacing: 15.h,
              children: [
                CustomButton.filled(
                  theme: theme,
                  text: "Продолжить",
                  onPressed:
                      (isEmailValid &&
                          isPasswordValid &&
                          isConfirmPasswordValid)
                      ? () {
                          if (role == 'candidate') {
                            Get.to(
                              () => RegistrationCandidatePage(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                                confirmPassword:
                                    widget.passwordConfirmController.text,
                              ),
                            );
                          } else if (role == 'company') {
                            Get.to(
                              () => RegistrationCompanyPage(
                                email: widget.emailController.text,
                                password: widget.passwordController.text,
                                confirmPassword:
                                    widget.passwordConfirmController.text,
                              ),
                            );
                          }
                        }
                      : null,
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

  void _updateFormValidity() {
    final nextEmailValid = emailKey.currentState?.validate() ?? false;
    final nextPasswordValid = passwordKey.currentState?.validate() ?? false;
    final nextConfirmPasswordValid =
        confirmPasswordKey.currentState?.validate() ?? false;

    setState(() {
      isEmailValid = nextEmailValid;
      isPasswordValid = nextPasswordValid;
      isConfirmPasswordValid = nextConfirmPasswordValid;
    });
  }
}
