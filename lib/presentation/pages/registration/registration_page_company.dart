import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationCompanyPage extends StatefulWidget {
  final nameController = TextEditingController();
  final companyNameController = TextEditingController();

  RegistrationCompanyPage({super.key});

  @override
  State<RegistrationCompanyPage> createState() =>
      _RegistrationCompanyPageState();
}

class _RegistrationCompanyPageState extends State<RegistrationCompanyPage> {
  // String selectedRole = Get.arguments;
  String selectedRegion = '';

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: "Создать аккаунт",
        subtitle: "Укажите данные компании",
      ),
      body: Padding(
        padding: .fromLTRB(16.h, 16.w, 16.w, 36.h),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .stretch,
              spacing: 5.h,
              children: [
                CustomTextInput(
                  controller: widget.companyNameController,
                  textHint: 'Введите название компании',
                  label: 'Название',
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextInput(
                  controller: widget.nameController,
                  textHint: 'Введите имя',
                  label: 'Имя',
                  onChanged: (_) => setState(() {}),
                ),
                CustomSelectorRegionWidget(
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value!;
                    });
                  },
                ),
              ],
            ),
            Column(
              spacing: 15.h,
              children: [
                CustomButton.filled(
                  theme: theme,
                  text: "Зарегистрироваться",
                  onPressed:
                      (widget.nameController.text.isNotEmpty &&
                          widget.companyNameController.text.isNotEmpty &&
                          selectedRegion.isNotEmpty)
                      ? () {}
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
}
