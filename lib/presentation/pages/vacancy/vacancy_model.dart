import 'package:profhunteruikit/uikit.dart';

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

class VacancyBackend extends VacancyModel {
  @override
  final String name = 'Backend-разработчик (Node.js)';

  @override
  final String salary = 'От 180 000 ₽';

  @override
  final String orgName = 'ООО "Цифровые решения"';

  @override
  final String employmentType = 'Полная занятость';

  @override
  final String place = 'Москва / Удалённо';

  @override
  final String address = '115093, г. Москва, ул. Люсиновская, д. 36';

  @override
  final List<String> duties = [
    'Разработка серверной логики на Node.js',
    'Проектирование и поддержка API',
    'Работа с базами данных',
  ];

  @override
  final List<String> requirements = [
    'Опыт работы с Node.js от 2 лет',
    'Знание JavaScript/TypeScript',
    'Опыт работы с SQL или NoSQL базами данных',
  ];

  @override
  final List<String> conditions = [
    'Официальное трудоустройство',
    'Гибридный формат работы',
    'Оплата курсов и обучения',
  ];

  @override
  final Map<String, String> contacts = {
    'email': 'jobs@digital.ru',
    'phone': '+7 (495) 123-45-67',
  };
}

class VacancyUIUX extends VacancyModel {
  @override
  final String name = 'UI/UX дизайнер';

  @override
  final String salary = 'От 120 000 ₽';

  @override
  final String orgName = 'Студия "Креатив"';

  @override
  final String employmentType = 'Частичная занятость';

  @override
  final String place = 'Удалённо';

  @override
  final String address = '191025, г. Санкт-Петербург, Невский пр., д. 72';

  @override
  final List<String> duties = [
    'Разработка интерфейсов мобильных и веб-приложений',
    'Создание прототипов и макетов',
    'Анализ пользовательского опыта',
  ];

  @override
  final List<String> requirements = [
    'Опыт работы дизайнером от 1 года',
    'Владение Figma/Sketch',
    'Понимание принципов UX',
  ];

  @override
  final List<String> conditions = [
    'Удалённая работа',
    'Свободный график',
    'Дружная команда',
  ];

  @override
  final Map<String, String> contacts = {
    'email': 'design@creative.ru',
    'phone': '+7 (812) 987-65-43',
  };
}
