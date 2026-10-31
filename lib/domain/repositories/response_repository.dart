import 'package:profhunterapp/domain/entities/response.dart';
import 'package:profhunterapp/domain/entities/response_view_data.dart';

abstract class ResponseRepository {
  Future<ResponseEntity> createVacancyResponse({
    required String idVacancy,
    required String idCandidate,
  });

  Future<List<ResponseEntity>> getUserResponses({required String idCandidate});

  Future<List<ResponseViewData>> getCompanyResponses();
}
