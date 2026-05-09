import 'package:profhunterapp/domain/entities/response.dart';
import 'package:profhunterapp/domain/repositories/response_repository.dart';

class CreateVacancyResponse {
  final ResponseRepository repository;

  CreateVacancyResponse(this.repository);

  Future<ResponseEntity> call({
    required String idVacancy,
    required String idCandidate
  }) async {
    return await repository.createVacancyResponse(
        idVacancy: idVacancy, idCandidate: idCandidate);
  }

}