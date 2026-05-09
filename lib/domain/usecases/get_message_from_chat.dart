import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/repositories/message_repository.dart';

class GetMessageFromChat {
  final MessageRepository repository;

  GetMessageFromChat(this.repository);

  Future<List<Message>> call({
    required String chatId,
  }) async {
    return await repository.getMessageFromChat(chatId: chatId);
  }
}
