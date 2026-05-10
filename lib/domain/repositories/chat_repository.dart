import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/message.dart';

abstract class ChatRepository {

  Future<ChatEntity> getChat({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
  });

  Future<void> subscribeMessages({
    required String chatId,
    required void Function(Message message) onMessage,
  });

  Future<void> unsubscribeMessages();
}