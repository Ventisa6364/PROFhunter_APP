import 'package:profhunterapp/domain/repositories/favorite_repository.dart';

class DeleteFavorite {
  final FavoriteRepository repository;

  DeleteFavorite(this.repository);

  Future<void> call({required String id}) {
    return repository.deleteFavorite(id: id);
  }
}
