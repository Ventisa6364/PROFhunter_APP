import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class DeleteVacancy {
  final VacancyRepository repository;

  DeleteVacancy(this.repository);

  Future<void> call({required String id}) async {
    await repository.deleteVacancy(id: id);
  }
}
