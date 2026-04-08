import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/auth/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunteruikit/uikit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    final controller = Get.find<AuthController>();
    final user = controller.user ?? controller.repository.currentUser;
    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16.w,
        scrolledUnderElevation: 0,
        backgroundColor: theme.palette.block,
        title: Text(
          'Профиль',
          style: CustomStyles.nunitoBold32.copyWith(color: theme.palette.text),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close, size: 32.sp),
            onPressed: () => Get.to(() => HomePage()),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: .symmetric(horizontal: 20.w, vertical: 8.h),
              child: Column(
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
                            'Я ищу работу',
                            style: CustomStyles.nunitoMedium14.copyWith(
                              color: theme.palette.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

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

                  SizedBox(height: 18.h),

                  ProfileCard(
                    title: 'Мои навыки',
                    child: Wrap(
                      spacing: 10.w,
                      runSpacing: 10.w,
                      children: [
                        SkillChip(label: 'Flutter'),
                        SkillChip(label: 'Dart'),
                        SkillChip(label: 'Firebase'),
                        SkillChip(label: 'REST API'),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

                  ProfileCard(
                    title: 'О себе',
                    child: Text(
                      'Начинающий mobile-разработчик. Ищу возможности для роста и участия в интересных проектах.',
                      style: CustomStyles.nunitoMedium16.copyWith(
                        color: theme.palette.text,
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: CustomButton.filled(
                      onPressed: () {},
                      text: 'Редактировать профиль',
                      theme: CustomTheme.of(context),
                      height: 48.h,
                      width: 336.w,
                    ),
                  ),

                  SizedBox(height: 14.h),

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

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getHome() => Get.to(HomePage());
}
