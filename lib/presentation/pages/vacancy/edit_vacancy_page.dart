import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunteruikit/uikit.dart';

class EditVacancyPage extends StatefulWidget {
  final Vacancy vacancy;

  const EditVacancyPage({super.key, required this.vacancy});

  @override
  State<EditVacancyPage> createState() => _EditVacancyPageState();
}

class _EditVacancyPageState extends State<EditVacancyPage> {
  final authController = Get.find<AuthController>();
  final vacancyController = Get.find<VacancyController>();

  late final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(text: widget.vacancy.name),
    'salary': TextEditingController(text: widget.vacancy.salary),
    'employmentType': TextEditingController(
      text: widget.vacancy.employmentType,
    ),
    'place': TextEditingController(text: widget.vacancy.place),
    'address': TextEditingController(text: widget.vacancy.address),
    'phone': TextEditingController(text: widget.vacancy.contacts['phone']),
    'email': TextEditingController(text: widget.vacancy.contacts['email']),
  };

  List<String> spControllersName = [
    'name',
    'salary',
    'employmentType',
    'place',
    'address',
    'phone',
    'email',
  ];

  late List<String> duties = widget.vacancy.duties;
  late List<String> requirements = widget.vacancy.requirements;
  late List<String> conditions = widget.vacancy.conditions;

  bool isValidData = false;

  void _updateFormValidity() {
    setState(() {
      for (int i = 0; i < spControllersName.length; i++) {
        isValidData = controllers[spControllersName[i]]!.text.isNotEmpty;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (final controller in controllers.values) {
      controller.addListener(_updateFormValidity);
    }
  }

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
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  VacancyTextField(
                    label: 'Название вакансии',
                    hint: 'Например: Flutter-разработчик',
                    controller: controllers['name']!,
                  ),

                  VacancyTextField(
                    label: 'Зарплата',
                    hint: 'Например: от 70 000 ₽',
                    controller: controllers['salary']!,
                  ),

                  VacancyTextField(
                    label: 'Место работы',
                    hint: 'Офис / удалённо / гибрид',
                    controller: controllers['place']!,
                  ),

                  VacancyTextField(
                    label: 'Адрес компании',
                    hint: 'Город, улица, офис',
                    controller: controllers['address']!,
                  ),

                  VacancyTextField(
                    label: 'Занятость',
                    hint: 'Полная / частичная / стажировка',
                    controller: controllers['employmentType']!,
                  ),

                  EditableListSection(
                    title: 'Обязанности',
                    hint: 'Добавить обязанность',
                    items: duties,
                    onChanged: () {
                      setState(() {});
                    },
                  ),

                  EditableListSection(
                    title: 'Требования',
                    hint: 'Добавить требование',
                    items: requirements,
                    onChanged: () {
                      setState(() {});
                    },
                  ),

                  EditableListSection(
                    title: 'Условия работы',
                    hint: 'Добавить условие',
                    items: conditions,
                    onChanged: () {
                      setState(() {});
                    },
                  ),

                  VacancyTextField(
                    label: 'Телефон для связи',
                    hint: '+7 999 999-99-99',
                    controller: controllers['phone']!,
                  ),

                  VacancyTextField(
                    label: 'Email компании',
                    hint: 'company@example.com',
                    controller: controllers['email']!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            (isValidData &&
                conditions.isNotEmpty &&
                duties.isNotEmpty &&
                requirements.isNotEmpty)
            ? () async {
                await vacancyController.editVacancy(
                  id: widget.vacancy.id,
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
                  userID: authController.user.value!.id,
                );

                await vacancyController.fetchVacancies();

                final vacancy = await vacancyController.getVacancyById(idVacancy: widget.vacancy.id);

                Get.toNamed('/vacancy-detail', arguments: vacancy);
              }
            : null,
        backgroundColor: theme.palette.block,
        elevation: 3,
        child: Icon(Icons.check, color: theme.palette.icon, size: 24.sp),
      ),
    );
  }

  void _getBack() => Get.back();
}
