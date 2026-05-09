import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class ChatRemoteDataSource {
  final PocketBase pb;

  ChatRemoteDataSource(this.pb);

  Future<Map<String, dynamic>?> getChat({
    required String idCompany,
    required String idCandidate,
  }) async {
    try {
      final result = await pb
          .collection('chat')
          .getFirstListItem(
            'idCompany = "$idCompany" && idCandidate = "$idCandidate"',
          );

      return {'id': result.id, ...result.data};
    } catch (_) {
      final record = await pb
          .collection('chat')
          .create(body: {'idCompany': idCompany, 'idCandidate': idCandidate});

      return {'id': record.id, ...record.data};
    }
  }
}
