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
    required super.userID,
  });

  factory VacancyModel.fromJson(Map<String, dynamic> map) {
    return VacancyModel(
      id: map['id'] ?? '',
      salary: map['salary'] ?? '',
      name: map['name'] ?? '',
      companyName: map['companyName'] ?? '',
      employmentType: map['employmentType'] ?? '',
      place: map['place'] ?? '',
      address: map['address'] ?? '',
      userID: map['userID'] ?? '',

      duties: List<String>.from(map['duties'] ?? []),
      requirements: List<String>.from(map['requirements'] ?? []),
      conditions: List<String>.from(map['conditions'] ?? []),

      contacts: Map<String, dynamic>.from(map['contacts'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salary': salary,
      'name': name,
      'companyName': companyName,
      'employmentType': employmentType,
      'place': place,
      'address': address,
      'duties': duties,
      'requirements': requirements,
      'conditions': conditions,
      'contacts': contacts,
      'userID': userID,
    };
  }
}
