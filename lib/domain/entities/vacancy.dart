class Vacancy {
  final String id;
  final String salary;
  final String name;
  final String companyName;
  final String employmentType;
  final String place;
  final String address;
  final List<String> duties;
  final List<String> requirements;
  final List<String> conditions;
  final Map<String, dynamic> contacts;

  Vacancy({
    required this.id,
    required this.salary,
    required this.name,
    required this.companyName,
    required this.employmentType,
    required this.place,
    required this.address,
    required this.duties,
    required this.requirements,
    required this.conditions,
    required this.contacts,
  });
}
