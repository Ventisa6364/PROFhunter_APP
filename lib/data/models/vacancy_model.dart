import 'package:profhunterapp/domain/entities/vacancy.dart';

class VacancyModel extends Vacancy {
  VacancyModel({
    required super.id,
    required super.salary,
    required super.name,
    required super.companyName,
    required super.employmentType,
    required super.place,
    required super.address,
    required super.duties,
    required super.requirements,
    required super.conditions,
    required super.contacts,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> map) {
    return VacancyModel(
      id: map['id'] as String? ?? '',
      salary: map['salary'] as String? ?? '',
      name: map['name'] as String? ?? '',
      companyName: map['company'] as String? ?? '',
      employmentType: map['employment'] as String? ?? '',
      place: map['place'] as String? ?? '',
      address: map['address'] as String? ?? '',
      duties: (map['duties'] as List?)?.map((e) => e.toString()).toList() ?? [],
      requirements: (map['requirements'] as List?)?.map((e) => e.toString()).toList() ?? [],
      conditions: (map['conditions'] as List?)?.map((e) => e.toString()).toList() ?? [],
      contacts: Map<String, dynamic>.from(map['contacts'] ?? {}),
    );
  }
}
