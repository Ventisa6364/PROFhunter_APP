import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/auth/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/profile.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationCandidatePage extends StatefulWidget {
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final controller = Get.find<AuthController>();

  final String email;
  final String password;
  final String confirmPassword;

  RegistrationCandidatePage({
    super.key,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

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
                  onPressed: (isNameValid && isSelectedRegionValid!)
                      ? () async {
                          await widget.controller.signUp(
                            email: widget.email,
                            password: widget.password,
                            passwordConfirm: widget.confirmPassword,
                            name: widget.nameController.text,
                            selectedRegion: selectedRegion!,
                            companyName: '',
                          );

                          await widget.controller.signIn(
                            email: widget.email,
                            password: widget.password,
                          );

                          Get.to(() => ProfileScreen());
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
    final nextNameValid = nameKey.currentState?.validate() ?? false;
    final nextSelectedRegionValid = selectedRegion != null;

    setState(() {
      isNameValid = nextNameValid;
      isSelectedRegionValid = nextSelectedRegionValid as bool?;
    });
  }
}
