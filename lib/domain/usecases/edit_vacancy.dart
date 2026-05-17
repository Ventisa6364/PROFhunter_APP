import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class EditVacancy {
  final VacancyRepository repository;

  EditVacancy({required this.repository});

  Future<Vacancy> call({
    required String id,
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required String userID,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
  }) async {
    return await repository.editVacancy(
      id: id,
      name: name,
      salary: salary,
      companyName: companyName,
      employmentType: employmentType,
      place: place,
      address: address,
      userID: userID,
      duties: duties,
      requirements: requirements,
      conditions: conditions,
      contacts: contacts,
    );
  }
}
