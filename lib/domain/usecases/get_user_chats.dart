import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class GetUserChats {
  final ChatRepository repository;

  GetUserChats(this.repository);

  Future<List<ChatEntity>> call({required String userID}) async {
    return await repository.getUserChats(userID: userID);
  }
}