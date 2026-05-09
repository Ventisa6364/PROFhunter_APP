import 'package:profhunterapp/data/datasources/message_remote_data_source.dart';
import 'package:profhunterapp/data/models/message_model.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Message> sendMessage({
    required String chatId,
    required String senderId,
    required String textMessage,
  }) async {
    final data = await remoteDataSource.sendMessage(
      chatId: chatId,
      senderId: senderId,
      textMessage: textMessage,
    );

    return MessageModel.fromJson(data);
  }
}
