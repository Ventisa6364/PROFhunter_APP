import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';
import 'package:profhunterapp/presentation/controllers/response_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class VacancyPage extends StatefulWidget {
  final Vacancy vacancy;

  const VacancyPage({super.key, required this.vacancy});

  @override
  State<VacancyPage> createState() => _VacancyPageState();
}

class _VacancyPageState extends State<VacancyPage> {
  final authController = Get.find<AuthController>();

  final responseController = Get.find<ResponseController>();

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: 'Вакансия',
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
      ),
      body: Obx(() {
        final isResponded = responseController.responses.any(
          (response) => response.idVacancy == widget.vacancy.id,
        );
        return SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 1.h, thickness: 1.r, color: theme.palette.border),
              VacancyHeroBlock(
                vacancyName: widget.vacancy.name,
                textChipsSalary: widget.vacancy.salary,
                textChipsEmploymentType: widget.vacancy.employmentType,
                textChipsPlace: widget.vacancy.place,
                isCandidate: (authController.user.value?.role == 'candidate')
                    ? true
                    : false,
                isResponded: isResponded,
                onTap: () async {
                  await responseController.createVacancyResponse(
                    idCandidate: authController.user.value!.id,
                    idVacancy: widget.vacancy.id,
                  );
                  await responseController.fetchResponse(
                    idCandidate: authController.user.value!.id,
                  );
                },
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: .all(16.r),
                child: Column(
                  spacing: 16.h,
                  children: [
                    InfoCard(
                      title: 'О компании',
                      child: CompanyInfoContent(
                        address: widget.vacancy.address,
                        orgName: widget.vacancy.companyName,
                      ),
                    ),
                    InfoCard(
                      title: 'Обязанности',
                      child: BulletList(items: widget.vacancy.duties),
                    ),
                    InfoCard(
                      title: 'Требования',
                      child: BulletList(items: widget.vacancy.requirements),
                    ),
                    InfoCard(
                      title: 'Условия работы',
                      child: BulletList(items: widget.vacancy.conditions),
                    ),
                    ContactsCard(
                      email: widget.vacancy.contacts['email']!,
                      phone: widget.vacancy.contacts['phone']!,
                      textBottomButton:
                          (authController.user.value?.role == 'candidate')
                          ? 'Написать работодателю'
                          : null,
                      onPressedBottomButton:
                          (authController.user.value?.role == 'candidate')
                          ? () async {
                              var chat = await chatController.getChat(
                                idCompany: widget.vacancy.userID,
                                idCandidate: authController.user.value!.id,
                                idVacancy: widget.vacancy.id,
                                userRole: authController.user.value!.role,
                              );

                              Get.toNamed('/chat', arguments: chat);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _getBack() => Get.back();
}
