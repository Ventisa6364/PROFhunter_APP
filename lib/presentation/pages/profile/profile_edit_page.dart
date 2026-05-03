import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class ProfileEditPage extends StatefulWidget {
  final emailController = TextEditingController();

  ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    final controller = Get.find<AuthController>();
    final user = controller.user.value;

    String? newName, newEmail, newAboutMyself, newAboutCompany, newRegion;
    widget.emailController.text = user!.email;
    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: 'Изменение профиля',
        iconBtn: Icons.close,
        onPressed: _close,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: .symmetric(horizontal: 20.w, vertical: 8.h),
              child: Column(
                spacing: 8.h,
                children: [
                  Container(
                    width: double.infinity,
                    padding: .all(20.r),
                    decoration: BoxDecoration(
                      color: theme.palette.block,
                      borderRadius: .circular(24.r),
                      border: .all(color: theme.palette.border),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32.r,
                          backgroundColor: theme.palette.blue.withAlpha(0x1f),
                          child: Icon(
                            Icons.person_outline,
                            size: 32.r,
                            color: theme.palette.blue,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          user.name,
                          style: CustomStyles.nunitoMedium14.copyWith(
                            color: theme.palette.textSecondary,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          user.email,
                          style: CustomStyles.nunitoMedium14.copyWith(
                            color: theme.palette.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: .symmetric(horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: theme.palette.blue.withAlpha(0x1f),
                            borderRadius: .circular(14.r),
                          ),
                          child: Text(
                            (user.role == 'candidate')
                                ? 'Я ищу работу'
                                : (user.role == 'company')
                                ? 'Я ищу сотрудников'
                                : 'Не указано',
                            style: CustomStyles.nunitoMedium14.copyWith(
                              color: theme.palette.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProfileCard(
                    title: 'Основная информация',
                    child: Column(
                      spacing: 16.h,
                      children: [
                        EditProfileRow(
                          icon: Icons.person_outline,
                          title: 'Имя',
                          value: user.name,
                          onChanged: (value) {
                            newName = value;
                          },
                        ),
                        EditProfileRow(
                          icon: Icons.location_on_outlined,
                          title: 'Регион',
                          value: user.selectedRegion,
                          onChanged: (value) {
                            newRegion = value;
                          },
                        ),
                        EditProfileRow(
                          icon: Icons.email_outlined,
                          title: 'E-mail',
                          value: user.email,
                          onChanged: (value) {
                            newEmail = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  if (user.role == 'candidate') ...[
                    EditAboutUserCard(
                      title: 'О себе',
                      value: user.aboutMyself,
                      onChanged: (value) {
                        newAboutMyself = value;
                      },
                    ),
                    EditSkillsCard(skills: user.skills),
                  ] else
                    EditAboutUserCard(
                      title: 'О компании',
                      value: user.aboutCompany,
                      onChanged: (value) {
                        newAboutCompany = value;
                      },
                    ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: CustomButton.filled(
                      onPressed: () async {
                        showBottomLoader(context);
                        try {
                          await controller.updateUser(
                            email: newEmail ?? user.email,
                            id: user.id,
                            name: newName ?? user.name,
                            companyName: user.companyName,
                            selectedRegion: newRegion ?? user.selectedRegion,
                            role: user.role,
                            avatar: user.avatar,
                            aboutMyself: newAboutMyself ?? user.aboutMyself,
                            aboutCompany: newAboutCompany ?? user.aboutCompany,
                            skills: user.skills,
                          );
                          hideLoader(context);
                        } catch (e) {
                          hideLoader(context);
                          await showErrorDialog(context, e.toString());
                        }
                      },
                      text: 'Сохранить',
                      theme: CustomTheme.of(context),
                      height: 48.h,
                      width: 336.w,
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _close() => Get.back();
}
