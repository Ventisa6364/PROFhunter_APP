import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class UnsubscribeMessages {
  final ChatRepository repository;

  UnsubscribeMessages(this.repository);

  Future<void> call() {
    return repository.unsubscribeMessages();
  }
}