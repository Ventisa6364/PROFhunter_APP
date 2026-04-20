import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<AppUser> call({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
  }) {
    return repository.signUp(
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
      name: name,
      companyName: companyName,
      selectedRegion: selectedRegion,
      role: role,
    );
  }
}
