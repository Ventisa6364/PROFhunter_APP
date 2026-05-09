import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/repositories/message_repository.dart';

class SendMessage {
  final MessageRepository repository;

  SendMessage(this.repository);

  Future<Message> call({
    required String chatId,
    required String senderId,
    required String textMessage,
  }) async {
    return await repository.sendMessage(
      chatId: chatId,
      senderId: senderId,
      textMessage: textMessage,
    );
  }
}
