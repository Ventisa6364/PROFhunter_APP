import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/message_model.dart';

class MessageRemoteDataSource {
  final PocketBase pb;

  MessageRemoteDataSource(this.pb);

  Future<Map<String, dynamic>> sendMessage({
    required String chatId,
    required String senderId,
    required String textMessage,
  }) async {
    final record = await pb
        .collection('message')
        .create(
          body: {
            'chatId': chatId,
            'senderId': senderId,
            'textMessage': textMessage,
          },
        );

    await pb.collection('chat').update(
      chatId,
      body: {
        'lastMessage': textMessage,
      },
    );

    return {'id': record.id, ...record.data};
  }

  Future<List<MessageModel>> getMessageFromChat({
    required String chatId,
  }) async {
    final result = await pb
        .collection('message')
        .getFullList(sort: 'created', filter: 'chatId = "$chatId"');

    return result.map((record) {
      return MessageModel.fromJson({'id': record.id, ...record.data});
    }).toList();
  }
}
