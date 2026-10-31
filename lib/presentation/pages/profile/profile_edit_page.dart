import 'package:profhunterapp/data/pocketbase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class ProfileEditPage extends StatefulWidget {
  final emailController = TextEditingController();

  ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  Future<void> imagePicker(AuthController authController) async {
    final picker = ImagePicker();

    var source = await chooseSource(context);

    final file = await picker.pickImage(source: source!, imageQuality: 80);

    if (file == null) return;

    final user = authController.user.value;

    if (user == null) return;

    await authController.updateAvatar(userID: user.id, imagePath: file.path);
  }

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
      body: Obx(() {
        final user = controller.user.value;
        final resume = user?.resume ?? '';
        final selectedResumeName = controller.selectedResumeName.value;
        final hasResume = resume.isNotEmpty || selectedResumeName.isNotEmpty;

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (user == null) {
          return const Center(child: Text('Пользователь не найден'));
        }

        return Column(
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
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  imagePicker(controller);
                                },
                                child: CircleAvatar(
                                  radius: 32.r,
                                  backgroundImage: user.avatar.isNotEmpty
                                      ? NetworkImage(
                                          pocketBaseUserFileUrl(user.id, user.avatar),
                                        )
                                      : null,
                                  child: user.avatar.isEmpty
                                      ? CircleAvatar(
                                          radius: 32.r,
                                          backgroundColor: theme.palette.blue
                                              .withAlpha(0x1f),
                                          child: Icon(
                                            Icons.person_outline,
                                            size: 32.r,
                                            color: theme.palette.blue,
                                          ),
                                        )
                                      : null,
                                ),
                              ),

                              if (user.avatar.isNotEmpty)
                                Positioned(
                                  right: -2.r,
                                  bottom: -2.r,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final result = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Удалить аватар?'),
                                          content: const Text(
                                            'Текущая фотография профиля будет удалена.',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text('Отмена'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text('Удалить'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (result == true) {
                                        await controller.deleteAvatar();
                                      }
                                    },
                                    child: Container(
                                      width: 24.r,
                                      height: 24.r,
                                      decoration: BoxDecoration(
                                        color: theme.palette.blue,
                                        shape: .circle,
                                        border: Border.all(
                                          color: theme.palette.background,
                                          width: 2.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.delete_outline,
                                        size: 14.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
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
                            padding: .symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
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
                            isRegion: true,
                            onChangedRegion: (value) {
                              newRegion = value;
                            },
                            defaultValue: user.selectedRegion,
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
                      ResumeBlock(
                        hasResume: hasResume,
                        fileName: selectedResumeName.isNotEmpty
                            ? selectedResumeName
                            : 'Резюме загружено',
                        isLoading: controller.isLoading.value,
                        onUpload: controller.pickAndUploadResume,
                        onReplace: controller.pickAndUploadResume,
                        onDelete: controller.deleteResume,
                      ),
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
                              aboutMyself: newAboutMyself ?? user.aboutMyself,
                              aboutCompany:
                                  newAboutCompany ?? user.aboutCompany,
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
        );
      }),
    );
  }

  void _close() => Get.back();
}
