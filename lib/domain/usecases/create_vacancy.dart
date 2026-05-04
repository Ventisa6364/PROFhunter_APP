import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class CreateVacancy {
  final VacancyRepository repository;

  CreateVacancy({required this.repository});

  Future<Vacancy> call({
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
  }) async {
    return await repository.createVacancy(
      name: name,
      salary: salary,
      companyName: companyName,
      employmentType: employmentType,
      place: place,
      address: address,
      duties: duties,
      requirements: requirements,
      conditions: conditions,
      contacts: contacts,
    );
  }
}
