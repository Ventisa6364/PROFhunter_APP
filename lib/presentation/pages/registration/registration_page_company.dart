import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunteruikit/uikit.dart';

class RegistrationCompanyPage extends StatefulWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final companyNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  RegistrationCompanyPage({super.key});

  @override
  State<RegistrationCompanyPage> createState() =>
      _RegistrationCompanyPageState();
}

class _RegistrationCompanyPageState extends State<RegistrationCompanyPage> {
  // String selectedRole = Get.arguments;
  String selectedRegion = '';

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWidget(
        title: "Создать аккаунт",
        subtitle: "Укажите данные компании",
      ),
      body: Padding(
        padding: .only(
          top: 16.h,
          right: 16.w,
          bottom: 36.h,
          left: 16.w,
        ),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .stretch,
              spacing: 5.h,
              children: [
                CustomTextInput(
                  controller: widget.companyNameController,
                  textHint: 'Введите название компании',
                  label: 'Название',
                ),
                CustomTextInput(
                  controller: widget.nameController,
                  textHint: 'Введите имя',
                  label: 'Имя',
                ),
                CustomSelectorWidget(
                  selectList: [
                    "Республика Адыгея (Адыгея)",
                    "Республика Башкортостан",
                    "Республика Бурятия",
                    "Республика Алтай",
                    "Республика Дагестан",
                    "Республика Ингушетия",
                    "Кабардино-Балкарская Республика",
                    "Республика Калмыкия",
                    "Карачаево-Черкесская Республика",
                    "Республика Карелия",
                    "Республика Коми",
                    "Республика Марий Эл",
                    "Республика Мордовия",
                    "Республика Саха (Якутия)",
                    "Республика Северная Осетия — Алания",
                    "Республика Татарстан (Татарстан)",
                    "Республика Тыва",
                    "Удмуртская Республика",
                    "Республика Хакасия",
                    "Чеченская Республика",
                    "Чувашская Республика — Чувашия",
                    "Алтайский край",
                    "Краснодарский край",
                    "Красноярский край",
                    "Приморский край",
                    "Ставропольский край",
                    "Хабаровский край",
                    "Амурская область",
                    "Архангельская область",
                    "Астраханская область",
                    "Белгородская область",
                    "Брянская область",
                    "Владимирская область",
                    "Волгоградская область",
                    "Вологодская область",
                    "Воронежская область",
                    "Ивановская область",
                    "Иркутская область",
                    "Калининградская область",
                    "Калужская область",
                    "Камчатский край",
                    "Кемеровская область",
                    "Кировская область",
                    "Костромская область",
                    "Курганская область",
                    "Курская область",
                    "Ленинградская область",
                    "Липецкая область",
                    "Магаданская область",
                    "Московская область",
                    "Мурманская область",
                    "Нижегородская область",
                    "Новгородская область",
                    "Новосибирская область",
                    "Омская область",
                    "Оренбургская область",
                    "Орловская область",
                    "Пензенская область",
                    "Пермский край",
                    "Псковская область",
                    "Ростовская область",
                    "Рязанская область",
                    "Самарская область",
                    "Саратовская область",
                    "Сахалинская область",
                    "Свердловская область",
                    "Смоленская область",
                    "Тамбовская область",
                    "Тверская область",
                    "Томская область",
                    "Тульская область",
                    "Тюменская область",
                    "Ульяновская область",
                    "Челябинская область",
                    "Забайкальский край",
                    "Ярославская область",
                    "г. Москва",
                    "Санкт-Петербург",
                    "Еврейская автономная область",
                    "Ненецкий автономный округ",
                    "Ханты-Мансийский автономный округ — Югра",
                    "Чукотский автономный округ",
                    "Ямало-Ненецкий автономный округ",
                  ],
                  label: 'Выберите регион',
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value!;
                    });
                  },
                  width: 400.w,
                  selectedValue: '',
                ),
              ],
            ),
            Column(
              spacing: 15.h,
              children: [
                CustomButton.filled(
                  theme: theme,
                  text: "Зарегистрироваться",
                  onPressed: () {},
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
}
