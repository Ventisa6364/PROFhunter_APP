import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunterapp/presentation/pages/profile/profile_edit_page.dart';
import 'package:profhunteruikit/uikit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    final controller = Get.find<AuthController>();
    final user = controller.user;
    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: 'Профиль',
        iconBtn: Icons.close,
        onPressed: _getHome,
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
                          user?.name ?? '',
                          style: CustomStyles.nunitoMedium18.copyWith(
                            color: theme.palette.text,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          user?.email ?? '',
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
                            (user?.role == 'candidate')
                                ? 'Я ищу работу'
                                : (user?.role == 'company')
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
                        ProfileRow(
                          icon: Icons.person_outline,
                          title: 'Имя',
                          value: user?.name ?? '',
                        ),
                        ProfileRow(
                          icon: Icons.location_on_outlined,
                          title: 'Регион',
                          value: user?.selectedRegion ?? '',
                        ),
                        ProfileRow(
                          icon: Icons.email_outlined,
                          title: 'E-mail',
                          value: user?.email ?? '',
                        ),
                      ],
                    ),
                  ),
                  ProfileCard(
                    title: 'Мои навыки',
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      children: [
                        ChipsWidget(
                          backgroundColor: theme.palette.blue.withAlpha(0x1f),
                          textColor: theme.palette.blue,
                          text: 'Flutter',
                        ),
                        ChipsWidget(
                          backgroundColor: theme.palette.blue.withAlpha(0x1f),
                          textColor: theme.palette.blue,
                          text: 'Dart',
                        ),
                        ChipsWidget(
                          backgroundColor: theme.palette.blue.withAlpha(0x1f),
                          textColor: theme.palette.blue,
                          text: 'Firebase',
                        ),
                        ChipsWidget(
                          backgroundColor: theme.palette.blue.withAlpha(0x1f),
                          textColor: theme.palette.blue,
                          text: 'REST API',
                        ),
                      ],
                    ),
                  ),
                  if (user?.role == 'candidate') ...[
                    ProfileCard(
                      title: 'О себе',
                      child: Text(
                        'Начинающий mobile-разработчик. Ищу возможности для роста и участия в интересных проектах.',
                        style: CustomStyles.nunitoMedium16.copyWith(
                          color: theme.palette.text,
                        ),
                      ),
                    ),
                    ProfileCard(
                      title: 'Мои навыки',
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.w,
                        children: [
                          ChipsWidget(
                            backgroundColor: theme.palette.blue.withAlpha(0x1f),
                            textColor: theme.palette.blue,
                            text: 'Flutter',
                          ),
                          ChipsWidget(
                            backgroundColor: theme.palette.blue.withAlpha(0x1f),
                            textColor: theme.palette.blue,
                            text: 'Dart',
                          ),
                          ChipsWidget(
                            backgroundColor: theme.palette.blue.withAlpha(0x1f),
                            textColor: theme.palette.blue,
                            text: 'Firebase',
                          ),
                          ChipsWidget(
                            backgroundColor: theme.palette.blue.withAlpha(0x1f),
                            textColor: theme.palette.blue,
                            text: 'REST API',
                          ),
                        ],
                      ),
                    ),
                  ] else
                    ProfileCard(
                      title: 'О компании',
                      child: Text(
                        'Перспективная IT-компания, ищущая не менее перспективных молодых сотрудников',
                        style: CustomStyles.nunitoMedium16.copyWith(
                          color: theme.palette.text,
                        ),
                      ),
                    ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: CustomButton.filled(
                      onPressed: () {
                        Get.to(() => ProfileEditPage());
                      },
                      text: 'Редактировать профиль',
                      theme: CustomTheme.of(context),
                      height: 48.h,
                      width: 336.w,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: CustomButton.simple(
                      onPressed: () {
                        controller.signOut();
                        Get.to(() => HomePage());
                      },
                      text: 'Выйти из аккаунта',
                      theme: theme,
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

  void _getHome() => Get.offAll(() => HomePage());
}
