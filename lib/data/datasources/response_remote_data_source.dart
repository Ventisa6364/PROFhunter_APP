import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/response_model.dart';

class ResponseRemoteDataSource {
  final PocketBase pb;

  ResponseRemoteDataSource(this.pb);

  Future<Map<String, dynamic>?> createVacancyResponse({
    required String idVacancy,
    required String idCandidate,
  }) async {
    final result = await pb
        .collection('response')
        .getList(
          page: 1,
          perPage: 1,
          filter: 'idVacancy = "$idVacancy" && idCandidate = "$idCandidate"',
        );

    if (result.items.isNotEmpty) return null;

    final record = await pb
        .collection('response')
        .create(body: {'idVacancy': idVacancy, 'idCandidate': idCandidate});

    return {'id': record.id, ...record.data};
  }

  Future<List<ResponseModel>> getUserResponses({required String idCandidate}) async {
    final result = await pb
        .collection('response')
        .getList(
          page: 1,
          perPage: 50,
          sort: '-created',
          filter: 'idCandidate = "$idCandidate"',
        );

    return result.items.map((record) {
      return ResponseModel.fromJson({'id': record.id, ...record.data});
    }).toList();
  }
}
