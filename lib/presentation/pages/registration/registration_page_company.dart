import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationCompanyPage extends StatefulWidget {
  final nameController = TextEditingController();
  final companyNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegistrationCompanyPage({super.key});

  @override
  State<RegistrationCompanyPage> createState() =>
      _RegistrationCompanyPageState();
}

class _RegistrationCompanyPageState extends State<RegistrationCompanyPage> {
  String? selectedRegion;
  final nameKey = GlobalKey<CustomTextInputState>();
  final companyNameKey = GlobalKey<CustomTextInputState>();

  late var isNameValid = nameKey.currentState?.validate() ?? false;
  late var isCompanyNameValid = companyNameKey.currentState?.validate() ?? false;
  late bool? isSelectedRegionValid = (selectedRegion != null);

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
            Form(
              key: widget._formKey,
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .stretch,
                spacing: 5.h,
                children: [
                  CustomTextInput.text(
                    key: companyNameKey,
                    controller: widget.companyNameController,
                    textHint: 'Введите название компании',
                    label: 'Название',
                    onChanged: (_) =>  _updateFormValidity()
                  ),
                  CustomTextInput.text(
                    key: nameKey,
                    controller: widget.nameController,
                    textHint: 'Введите имя',
                    label: 'Имя',
                    onChanged: (_) =>  _updateFormValidity(),
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
                  onPressed: (isNameValid && isCompanyNameValid && isSelectedRegionValid!) ? () {
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
    final nextCompanyNameValid = companyNameKey.currentState?.validate() ?? false;
    final nextSelectedRegionValid = selectedRegion != null;

    setState(() {
      isNameValid = nextNameValid;
      isCompanyNameValid = nextCompanyNameValid;
      isSelectedRegionValid = nextSelectedRegionValid as bool?;
    });
  }
}
