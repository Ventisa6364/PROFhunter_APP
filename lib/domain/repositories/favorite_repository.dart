import 'package:profhunterapp/domain/entities/favorite.dart';
import 'package:profhunterapp/domain/entities/favorite_view_data.dart';

abstract class FavoriteRepository {
  Future<Favorite> addFavorite({
    required String user,
    required String vacancy,
  });

  Future<void> deleteFavorite({required String id});

  Future<List<FavoriteViewData>> getUserFavorite({required String user});
}