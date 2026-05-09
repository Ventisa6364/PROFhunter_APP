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
        .create(body: {'chat': chatId, 'sender': senderId, 'textMessage': textMessage});

    return {'id': record.id, ...record.data};
  }
}
