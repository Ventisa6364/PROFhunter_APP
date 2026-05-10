import 'package:profhunterapp/data/datasources/chat_remote_data_source.dart';
import 'package:profhunterapp/data/models/chat_model.dart';
import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatEntity> getChat({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
  }) async {
    final data = await remoteDataSource.getChat(
      idCompany: idCompany,
      idVacancy: idVacancy,
      idCandidate: idCandidate,
    );

    return ChatModel.fromJson(data!);
  }

  @override
  Future<void> subscribeMessages({
    required String chatId,
    required void Function(Message message) onMessage,
  }) {
    return remoteDataSource.subscribeMessages(
      chatId: chatId,
      onMessage: onMessage,
    );
  }

  @override
  Future<void> unsubscribeMessages() {
    return remoteDataSource.unsubscribeMessages();
  }
}
