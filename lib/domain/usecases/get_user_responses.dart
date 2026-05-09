import 'package:profhunterapp/domain/entities/response.dart';
import 'package:profhunterapp/domain/repositories/response_repository.dart';

class GetUserResponses {
  final ResponseRepository repository;

  GetUserResponses(this.repository);

  Future<List<ResponseEntity>> call({required String idCandidate}) async {
    return await repository.getUserResponses(idCandidate: idCandidate);
  }
}
