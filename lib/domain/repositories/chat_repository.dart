import 'package:profhunterapp/domain/entities/chat_entity.dart';

abstract class ChatRepository {

  Future<ChatEntity> createChat({
    required String idCompany,
    required String idCandidate,
  });
}