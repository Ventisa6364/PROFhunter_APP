import 'package:profhunterapp/domain/entities/favorite_view_data.dart';
import 'package:profhunterapp/domain/repositories/favorite_repository.dart';

class GetUserFavorite {
  final FavoriteRepository repository;

  GetUserFavorite(this.repository);

  Future<List<FavoriteViewData>> call({required String user}) {
    return repository.getUserFavorite(user: user);
  }
}
