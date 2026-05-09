import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class GetVacancyById {
  final VacancyRepository repository;

  GetVacancyById({required this.repository});

  Future<Vacancy> call({required String idVacancy}) async {
    return await repository.getVacancyById(idVacancy: idVacancy);
  }
}
