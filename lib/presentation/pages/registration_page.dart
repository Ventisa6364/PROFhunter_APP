import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/auth_page.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationPage extends StatefulWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: .only(
          top: 40.h,
          right: 20.w,
          bottom: 52.h,
          left: 20.w,
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
                      child: Icon(Icons.arrow_back_rounded),
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
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .stretch,
                  spacing: 14.h,
                  children: [
                    CustomTextInput(
                      widget.nameController,
                      textHint: 'Введите имя',
                      label: 'Имя',
                    ),
                    CustomTextInput(
                      widget.emailController,
                      textHint: 'email@example.com',
                      label: 'E-mail',
                    ),
                    CustomPasswordInput(
                      passwordController: widget.passwordController,
                      label: 'Пароль',
                    ),
                    CustomPasswordInput(
                      passwordController: widget.passwordConfirmController,
                      label: 'Повторите пароль',
                    ),
                    CustomSelectorWidget(
                      selectList: ['Работодатель', 'Соискатель'],
                      label: 'Выберите роль',
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              spacing: 28.h,
              children: [
                SizedBox.fromSize(
                  size: .new(336.w, 48.h),
                  child: CustomButton.filled(
                    theme: theme,
                    text: "Зарегистрироваться",
                    onPressed: () {},
                    height: 48.h,
                    width: 336.w,
                  ),
                ),
                GestureDetector(
                  onTap: _getSignUp,
                  child: Text(
                    "Уже есть аккаунт? Нажмите сюда, чтобы войти",
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

  void _getBack() => Get.back();
}
