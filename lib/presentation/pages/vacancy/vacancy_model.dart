abstract class VacancyModel {
  abstract final String name;
  abstract final String salary;
  abstract final String orgName;
  abstract final String employmentType;
  abstract final String place;
  abstract final String address;
  abstract final List<String> duties;
  abstract final List<String> requirements;
  abstract final List<String> conditions;
  abstract final Map<String, String> contacts;
}

class VacancyPython extends VacancyModel {
  @override
  final String name = 'Python-developer';

  @override
  final String salary = 'От 100 000 ₽';

  @override
  final String orgName = 'ООО "Интернет решения"';

  @override
  final String employmentType = 'Полный день';

  @override
  final String place = 'Офис, Москва';

  @override
  final String address =
      '123112, г. Москва, Пресненская наб., д. 10, эт. 41, Пом. I, комн. 6';

  @override
  final List<String> duties = [
    'Написание кода',
    'Поддержка кода',
    'Чистка кода',
  ];

  @override
  final List<String> requirements = [
    'Опыт от 2 лет',
    'Умение работы с flask и django',
    'Любовь к печенькам',
  ];

  @override
  final List<String> conditions = [
    'График договорный',
    'От 100 000 тыс. руб. до вычета налогов',
    'Удаленная работа или офис',
  ];

  @override
  final Map<String, String> contacts = {
    'email': 'example@gmail.com',
    'phone': '8 (999) 232-32-23',
  };
}


class VacancyFlutter extends VacancyModel {
  @override
  final String name = 'Flutter-разработчик';

  @override
  final String salary = 'От 150 000 ₽';

  @override
  final String orgName = 'ООО "Мобильные технологии"';

  @override
  final String employmentType = 'Удалённая работа';

  @override
  final String place = 'Удалённо / Санкт-Петербург';

  @override
  final String address =
      '197101, г. Санкт-Петербург, Каменноостровский пр., д. 40';

  @override
  final List<String> duties = [
    'Разработка мобильных приложений на Flutter',
    'Интеграция API',
    'Оптимизация производительности приложений',
  ];

  @override
  final List<String> requirements = [
    'Опыт работы с Flutter от 1 года',
    'Знание Dart',
    'Опыт работы с REST API',
  ];

  @override
  final List<String> conditions = [
    'Гибкий график',
    'Удалённая работа',
    'ДМС после испытательного срока',
  ];

  @override
  final Map<String, String> contacts = {
    'email': 'hr@mobiletech.ru',
    'phone': '+7 (812) 555-12-34',
  };
}