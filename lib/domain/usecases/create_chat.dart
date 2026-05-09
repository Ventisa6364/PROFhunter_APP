import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class CreateChat {
  final ChatRepository repository;

  CreateChat(this.repository);

  Future<ChatEntity> call({
    required String idCandidate,
    required String idCompany,
  }) async {
    return await repository.createChat(
      idCompany: idCompany,
      idCandidate: idCandidate,
    );
  }
}
