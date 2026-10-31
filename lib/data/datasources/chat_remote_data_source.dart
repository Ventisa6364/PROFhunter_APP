import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/chat_model.dart';
import 'package:profhunterapp/data/models/message_model.dart';

class ChatRemoteDataSource {
  final PocketBase pb;

  ChatRemoteDataSource(this.pb);

  Future<Map<String, dynamic>?> getChat({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
  }) async {
    try {
      final result = await pb
          .collection('chat')
          .getFirstListItem(
            'idCompany = "$idCompany" && idVacancy = "$idVacancy" && idCandidate = "$idCandidate"',
          );

      return {'id': result.id, ...result.data};
    } on ClientException catch (error) {
      if (error.statusCode != 404) rethrow;
      final record = await pb
          .collection('chat')
          .create(
            body: {
              'idCompany': idCompany,
              'idVacancy': idVacancy,
              'idCandidate': idCandidate,
            },
          );

      return {'id': record.id, ...record.data};
    }
  }

  Future<void> subscribeMessages({
    required String chatId,
    required void Function(MessageModel message) onMessage,
  }) async {
    await pb.collection('message').subscribe('*', (e) {
      if (e.action != 'create' || e.record == null) return;

      final message = MessageModel.fromJson({
        'id': e.record!.id,
        ...e.record!.data,
      });

      if (message.chatId == chatId) {
        onMessage(message);
      }
    });
  }

  Future<void> unsubscribeMessages() async {
    await pb.collection('message').unsubscribe('*');
  }

  Future<List<ChatModel>> getUserChats({required String userID}) async {
    final result = await pb
        .collection('chat')
        .getList(
      page: 1,
      perPage: 50,
      sort: '-created',
      filter: 'idCandidate = "$userID" || idCompany = "$userID"',
    );

    return result.items.map((record) {
      return ChatModel.fromJson({'id': record.id, ...record.data});
    }).toList();
  }
}
