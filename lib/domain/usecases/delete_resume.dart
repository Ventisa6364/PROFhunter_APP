import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class DeleteResume {
  final AuthRepository repository;

  DeleteResume(this.repository);

  Future<AppUser> call({required String userID}) async {
    return await repository.deleteResume(userID: userID);
  }
}
