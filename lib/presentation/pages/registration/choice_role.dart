import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration/email_pass_page.dart';
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
      appBar: CustomAppBarWidget(
        title: "Создать аккаунт",
        subtitle: "Выберите роль, чтобы продолжить",
      ),
      body: Center(
          child: Column(
              spacing: 4.h,
              mainAxisAlignment: .center,
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
                SizedBox(height: 10.h),
                CustomButton.filled(
                  onPressed: () {
                    Get.to(EmailAndPassPage(), arguments: 'company');
                  },
                  text: 'Я ищу сотрудников',
                  theme: theme,
                  height: 48.h,
                  width: 336.w,
                ),
                SizedBox(height: 6.h),
                Text(
                  'В дальнейшем роль можно изменить',
                  style: CustomStyles.nunitoLight14.copyWith(
                    color: theme.palette.textSecondary,
                  ),
                ),
              ],
            ),
        ),
    );
  }
}
