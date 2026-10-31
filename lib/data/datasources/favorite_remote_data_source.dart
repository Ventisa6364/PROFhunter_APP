import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/favorite_model.dart';
import 'package:profhunterapp/data/models/vacancy_model.dart';
import 'package:profhunterapp/domain/entities/favorite_view_data.dart';

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

  Future<List<FavoriteViewData>> getUserFavorite({required String user}) async {
    final result = await pb
        .collection('favorite')
        .getList(
          perPage: 50,
          sort: '-created',
          filter: 'user="$user"',
          expand: 'vacancy',
        );

    return result.items.map((record) {
      final favorite = FavoriteModel.fromJson({
        'id': record.id,
        ...record.data,
      });

      final vacancyData = record.get<RecordModel>('expand.vacancy');

      final vacancy = VacancyModel.fromJson({
        'id': vacancyData.id,
        ...vacancyData.data,
      });

      return FavoriteViewData(favorite: favorite, vacancy: vacancy);
    }).toList();
  }
}
