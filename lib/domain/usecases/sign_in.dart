import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<AppUser> call({
    required String email,
    required String password,
}) {
    return repository.signIn(email: email, password: password);
  }
}