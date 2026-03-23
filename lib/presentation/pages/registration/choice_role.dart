import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration/choice_region.dart';
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
                      child: Icon(Icons.arrow_back_rounded, color: theme.palette.icon,),
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
                          "Перед регистрацией выберите \nсвою роль",
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
                    CustomSelectorWidget(
                      selectList: ['Соискатель', 'Работодатель'],
                      label: 'Выберите роль',
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      width: 400.w, selectedValue: 'Соискатель',
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
                    Get.to(ChoiceRegionPage(), arguments: selectedValue);
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
