import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class DeleteAvatar {
  final AuthRepository repository;

  DeleteAvatar(this.repository);

  Future<AppUser> call({required String userID}) async {
    return await repository.deleteAvatar(userID: userID);
  }
}