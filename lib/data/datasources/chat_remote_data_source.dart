import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/chat_model.dart';

class ChatRemoteDataSource {
  final PocketBase pb;

  ChatRemoteDataSource(this.pb);

  Future<Map<String, dynamic>> createChat({
    required String idCompany,
    required String idCandidate,
  }) async {
    final record = await pb
        .collection('chat')
        .create(body: {'idCompany': idCompany, 'idCandidate': idCandidate});

    return {'id': record.id, ...record.data};;
  }
}
