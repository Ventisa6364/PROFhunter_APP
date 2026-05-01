import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/profile/profile.dart';
import 'package:profhunteruikit/uikit.dart';

class SignInPage extends StatefulWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final role = Get.arguments;
  final emailKey = GlobalKey<CustomTextInputState>();
  final passwordKey = GlobalKey<CustomPasswordInputState>();

  final controller = Get.find<AuthController>();

  late var isEmailValid = emailKey.currentState?.validate() ?? false;
  late var isPasswordValid = passwordKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Вход',
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
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
                  onPressed: (isEmailValid && isPasswordValid)
                      ? () async {
                          showBottomLoader(context);
                          try {
                            await controller.signIn(
                              email: widget.emailController.text,
                              password: widget.passwordController.text,
                            );

                            if (controller.isLoggedIn) {
                              Get.to(() => const ProfileScreen());
                            }
                          } catch (e) {
                            hideLoader(context);
                            await showErrorDialog(context, e.toString());
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

  void _getBack() => Get.back();

  void _updateFormValidity() {
    final nextEmailValid = emailKey.currentState?.validate() ?? false;
    final nextPasswordValid = passwordKey.currentState?.validate() ?? false;

    setState(() {
      isEmailValid = nextEmailValid;
      isPasswordValid = nextPasswordValid;
    });
  }
}
