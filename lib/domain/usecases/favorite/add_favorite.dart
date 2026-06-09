import 'package:profhunterapp/domain/entities/favorite.dart';
import 'package:profhunterapp/domain/repositories/favorite_repository.dart';

class AddFavorite {
  final FavoriteRepository repository;

  AddFavorite(this.repository);

  Future<Favorite> call({required String user, required String vacancy}) {
    return repository.addFavorite(user: user, vacancy: vacancy);
  }
}
