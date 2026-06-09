import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/favorite_model.dart';

class FavoriteRemoteDataSource {
  final PocketBase pb;

  FavoriteRemoteDataSource(this.pb);

  Future<Map<String, dynamic>> addFavorite({
    required String user,
    required String vacancy,
  }) async {
    final record = await pb
        .collection('favorite')
        .create(body: {'user': user, 'vacancy': vacancy});

    return {'id': record.id, ...record.data};
  }

  Future<void> deleteFavorite({required String id}) async {
    await pb.collection('favorite').delete(id);
  }

  Future<List<FavoriteModel>> getUserFavorite({
    required String user,
  }) async {
    final result = await pb
        .collection('favorite')
        .getList(page: 1,
        perPage: 50,
        sort: '-created',
        filter: 'user = "$user"',);

    return result.items.map((record) {
      return FavoriteModel.fromJson({'id': record.id, ...record.data});
    }).toList();
  }
}
