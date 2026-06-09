import 'package:profhunterapp/data/datasources/favorite_remote_data_source.dart';
import 'package:profhunterapp/data/models/favorite_model.dart';
import 'package:profhunterapp/domain/entities/favorite.dart';
import 'package:profhunterapp/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Favorite> addFavorite({
    required String user,
    required String vacancy,
  }) async {
    final data = await remoteDataSource.addFavorite(
      user: user,
      vacancy: vacancy,
    );

    return FavoriteModel.fromJson(data);
  }

  @override
  Future<void> deleteFavorite({required String id}) async {
    await remoteDataSource.deleteFavorite(id: id);
  }

  @override
  Future<List<Favorite>> getUserFavorite({required String user}) async {
    return await remoteDataSource.getUserFavorite(user: user);
  }
}
