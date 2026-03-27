import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration/email_pass_page.dart';
import 'package:profhunterapp/presentation/pages/registration/registration_page_candidate.dart';
import 'package:profhunteruikit/uikit.dart';

class ChoiceRolePage extends StatefulWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  ChoiceRolePage({super.key});

  @override
  State<ChoiceRolePage> createState() => _ChoiceRolePageState();
}

class _ChoiceRolePageState extends State<ChoiceRolePage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: .only(
          top: 28.h,
          right: 15.w,
          bottom: 30.h,
          left: 15.w,
        ).add(MediaQuery.paddingOf(context)),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _getBack,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: theme.palette.icon,
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 12.h,
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
                        "Выберите роль, чтобы продолжить",
                        style: CustomStyles.nunitoMedium16.copyWith(
                          color: theme.palette.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.h),
            Spacer(),
            Expanded(
              child: Column(
                spacing: 4.h,
                children: [
                  CustomButton.filled(
                    onPressed: () {
                      Get.to(EmailAndPassPage(), arguments: 'candidate');
                    },
                    text: 'Я ищу работу',
                    theme: theme,
                    height: 52.h,
                    width: 336.w,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton.filled(
                    onPressed: () {
                      Get.to(EmailAndPassPage(), arguments: 'company');
                    },
                    text: 'Я ищу сотрудников',
                    theme: theme,
                    height: 48.h,
                    width: 336.w,
                  ),
                  SizedBox(height: 12.h),
                  Text('В дальнейшем роль можно изменить', style: CustomStyles.nunitoMedium14.copyWith(color: theme.palette.textSecondary),)
                ],
              ),
            ),
            Spacer(),
            // Column(
            //   spacing: 15.h,
            //   children: [
            //     CustomButton.filled(
            //       theme: theme,
            //       text: "Продолжить",
            //       onPressed: () {
            //         Get.to(RegistrationPage(), arguments: selectedValue);
            //       },
            //       height: 48.h,
            //       width: 336.w,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void _getBack() => Get.back();
}
