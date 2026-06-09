import 'package:profhunterapp/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Favorite> addFavorite({
    required String user,
    required String vacancy,
  });

  Future<void> deleteFavorite({required String id});

  Future<List<Favorite>> getUserFavorite({required String user});
}