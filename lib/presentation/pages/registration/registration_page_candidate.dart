import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationCandidatePage extends StatefulWidget {
  final nameController = TextEditingController();
  final role = Get.arguments;
  final _formKey = GlobalKey<FormState>();

  RegistrationCandidatePage({super.key});

  @override
  State<RegistrationCandidatePage> createState() =>
      _RegistrationCandidatePageState();
}

class _RegistrationCandidatePageState extends State<RegistrationCandidatePage> {
  String? selectedRegion;
  final nameKey = GlobalKey<CustomTextInputState>();

  late var isNameValid = nameKey.currentState?.validate() ?? false;
  late bool? isSelectedRegionValid = (selectedRegion != null);

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: "Создать аккаунт",
        subtitle: "Заполните основные данные",
      ),
      body: Padding(
        padding: .fromLTRB(16.h, 16.w, 16.w, 36.h),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Form(
              key: widget._formKey,
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .stretch,
                spacing: 4.h,
                children: [
                  CustomTextInput.text(
                    key: nameKey,
                    controller: widget.nameController,
                    textHint: 'Введите имя',
                    label: 'Имя',
                    onChanged: (_) => _updateFormValidity(),
                  ),
                  CustomSelectorRegionWidget(
                    onChanged: (value) {
                      _updateFormValidity();
                      setState(() {
                        selectedRegion = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Column(
              spacing: 15.h,
              children: [
                CustomButton.filled(
                  theme: theme,
                  text: "Зарегистрироваться",
                  onPressed: (isNameValid && isSelectedRegionValid!) ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Обработка данных')),
                      );
                    } : null,
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
    final nextNameValid = nameKey.currentState?.validate() ?? false;
    final nextSelectedRegionValid = selectedRegion != null;

    setState(() {
      isNameValid = nextNameValid;
      isSelectedRegionValid = nextSelectedRegionValid as bool?;
    });
  }
}
