import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class RestoreCurrentUser {
  final AuthRepository repository;


  RestoreCurrentUser(this.repository);


  Future<AppUser?> call() {
    return repository.restoreCurrentUser();
  }
}
