import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class GetUserById {
  final AuthRepository repository;

  GetUserById(this.repository);

  Future<AppUser> call({required String userID}) async {
    return await repository.getUserById(userID: userID);
  }
}