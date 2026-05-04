import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunterapp/presentation/pages/profile/profile_edit_page.dart';
import 'package:profhunteruikit/uikit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                          user.value!.name,
                          style: CustomStyles.nunitoMedium18.copyWith(
                            color: theme.palette.text,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          user.value!.email,
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
                            (user.value!.role == 'candidate')
                                ? 'Я ищу работу'
                                : (user.value!.role == 'company')
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
                          value: user.value!.name,
                        ),
                        ProfileRow(
                          icon: Icons.location_on_outlined,
                          title: 'Регион',
                          value: user.value!.selectedRegion,
                        ),
                        ProfileRow(
                          icon: Icons.email_outlined,
                          title: 'E-mail',
                          value: user.value!.email,
                        ),
                      ],
                    ),
                  ),
                  if (user.value!.role == 'candidate') ...[
                    ProfileCard(
                      title: 'О себе',
                      child: Text(
                        user.value?.aboutMyself.isNotEmpty == true
                            ? user.value!.aboutMyself
                            : 'Здесь пока пусто',
                        style: CustomStyles.nunitoMedium16.copyWith(
                          color: theme.palette.textSecondary,
                        ),
                      ),
                    ),
                    ProfileCard(
                      title: 'Мои навыки',
                      child: Wrap(
                        spacing: 10.w,
                        runSpacing: 10.w,
                        children: [
                          if (user.value?.skills.isNotEmpty == true)
                            for (int i = 0; i < user.value!.skills.length; i++)
                              ChipsWidget(
                                backgroundColor: theme.palette.blue.withAlpha(
                                  0x1f,
                                ),
                                textColor: theme.palette.blue,
                                text: user.value!.skills[i],
                              )
                          else
                            Text(
                              'Здесь пока пусто',
                              style: CustomStyles.nunitoMedium16.copyWith(
                                color: theme.palette.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ] else
                    ProfileCard(
                      title: 'О компании',
                      child: Text(
                        user.value!.aboutCompany,
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
                      onPressed: () async {
                        await Get.to(() => ProfileEditPage());

                        setState(() {});
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
                        Get.offAll(() => HomePage());
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

  void _close() => Get.to(() => HomePage());
}
