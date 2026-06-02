import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class AddResume {
  final AuthRepository repository;

  AddResume(this.repository);

  Future<AppUser> call({required String userID, required String filePath}) {
    return repository.addResume(userID: userID, filePath: filePath);
  }
}