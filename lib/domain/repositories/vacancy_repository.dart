import 'package:profhunterapp/domain/entities/vacancy.dart';

abstract class VacancyRepository {
  Future<List<Vacancy>> getVacancies();

  Future<Vacancy> createVacancy({
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
});
}