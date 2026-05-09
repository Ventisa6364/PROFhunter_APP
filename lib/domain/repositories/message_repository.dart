import 'package:profhunterapp/domain/entities/message.dart';

abstract class MessageRepository {

  Future<Message> sendMessage({
    required String chatId,
    required String senderId,
    required String textMessage,
  });
}