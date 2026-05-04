import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunteruikit/uikit.dart';

class CreateVacancyPage extends StatefulWidget {
  const CreateVacancyPage({super.key});

  @override
  State<CreateVacancyPage> createState() => _CreateVacancyPageState();
}

class _CreateVacancyPageState extends State<CreateVacancyPage> {
  final authController = Get.find<AuthController>();
  final vacancyController = Get.find<VacancyController>();

  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'salary': TextEditingController(),
    'employmentType': TextEditingController(),
    'place': TextEditingController(),
    'address': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
  };

  List<String> duties = [];
  List<String> requirements = [];
  List<String> conditions = [];

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
      body: Column(
        children: [
          Divider(height: 1.h, thickness: 2.r, color: theme.palette.border),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: .all(16.h),
                child: Column(
                  children: [
                    VacancyTextField(
                      label: 'Название вакансии',
                      controller: controllers['name']!,
                    ),

                    VacancyTextField(
                      label: 'Зарплата',
                      controller: controllers['salary']!,
                    ),

                    VacancyTextField(
                      label: 'Место работы',
                      controller: controllers['place']!,
                      maxLines: 10,
                    ),

                    VacancyTextField(
                      label: 'Адрес компании',
                      controller: controllers['address']!,
                      maxLines: 10,
                    ),

                    VacancyTextField(
                      label: 'Занятость',
                      controller: controllers['employmentType']!,
                    ),

                    EditableListSection(title: 'Обязанности', items: duties),

                    EditableListSection(
                      title: 'Требования',
                      items: requirements,
                    ),

                    EditableListSection(
                      title: 'Условия работы',
                      items: conditions,
                    ),

                    VacancyTextField(
                      label: 'Телефон для связи',
                      controller: controllers['phone']!,
                    ),

                    VacancyTextField(
                      label: 'Email компании',
                      controller: controllers['email']!,
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await vacancyController.createVacancy(
            name: controllers['name']!.text,
            salary: controllers['salary']!.text,
            companyName: authController.user.value!.companyName,
            employmentType: controllers['employmentType']!.text,
            place: controllers['place']!.text,
            address: controllers['address']!.text,
            duties: duties,
            requirements: requirements,
            conditions: conditions,
            contacts: {
              'email': controllers['email']!.text,
              'phone': controllers['phone']!.text,
            },
          );

          Get.offAll(() => HomePage());
        },
        backgroundColor: theme.palette.block,
        elevation: 3,
        child: Icon(Icons.check, color: theme.palette.icon, size: 24.sp),
      ),
    );
  }

  void _getBack() => Get.back();
}
