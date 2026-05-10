import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class SubscribeMessages {
  final ChatRepository repository;

  SubscribeMessages(this.repository);

  Future<void> call({
    required String chatId,
    required void Function(Message message) onMessage,
  }) {
    return repository.subscribeMessages(
      chatId: chatId,
      onMessage: onMessage,
    );
  }
}