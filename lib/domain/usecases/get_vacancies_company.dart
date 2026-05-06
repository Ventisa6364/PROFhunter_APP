import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class GetVacanciesCompany {
  final VacancyRepository repository;

  GetVacanciesCompany({required this.repository});

  Future<List<Vacancy>> call() async {
    return await repository.getVacanciesCompany();
  }
}