import 'package:profhunterapp/domain/entities/response.dart';

abstract class ResponseRepository {
  Future<ResponseEntity> createVacancyResponse({
    required String idVacancy,
    required String idCandidate,
  });

  Future<List<ResponseEntity>> getUserResponses({required String idCandidate});
}
