import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class UpdateAvatar {
  final AuthRepository repository;

  UpdateAvatar(this.repository);

  Future<AppUser> call({required String userID, required String imagePath}) {
    return repository.updateAvatar(userID: userID, imagePath: imagePath);
  }
}
