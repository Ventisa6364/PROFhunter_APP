import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class OtherProfileScreen extends StatefulWidget {
  final String otherUser;

  const OtherProfileScreen({super.key, required this.otherUser});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  final authController = Get.find<AuthController>();
  AppUser? user;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    try {
      final result = await authController.getUserById(userID: widget.otherUser);

      if (!mounted) return;

      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(body: Center(child: Text(errorMessage!)));
    }

    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(
        title: user!.name,
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
                          user!.name,
                          style: CustomStyles.nunitoMedium18.copyWith(
                            color: theme.palette.text,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          padding: .symmetric(horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: theme.palette.blue.withAlpha(0x1f),
                            borderRadius: .circular(14.r),
                          ),
                          child: Text(
                            (user!.role == 'candidate')
                                ? 'Я ищу работу'
                                : (user!.role == 'company')
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
                          value: user!.name,
                        ),
                        ProfileRow(
                          icon: Icons.location_on_outlined,
                          title: 'Регион',
                          value: user!.selectedRegion,
                        ),
                      ],
                    ),
                  ),
                  ProfileCard(
                    title: 'О себе',
                    child: Text(
                      user!.aboutMyself.isNotEmpty == true
                          ? user!.aboutMyself
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
                        if (user!.skills.isNotEmpty == true)
                          for (int i = 0; i < user!.skills.length; i++)
                            ChipsWidget(
                              backgroundColor: theme.palette.blue.withAlpha(
                                0x1f,
                              ),
                              textColor: theme.palette.blue,
                              text: user!.skills[i],
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
