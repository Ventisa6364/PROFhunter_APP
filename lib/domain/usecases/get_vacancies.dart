import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class GetVacancies {
  final VacancyRepository repository;

  GetVacancies({required this.repository});

  Future<List<Vacancy>> call() async {
    return await repository.getVacancies();
  }
}