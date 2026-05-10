import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class GetChat {
  final ChatRepository repository;

  GetChat(this.repository);

  Future<ChatEntity> call({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
  }) async {
    return await repository.getChat(
      idCompany: idCompany,
      idVacancy: idVacancy,
      idCandidate: idCandidate,
    );
  }
}
