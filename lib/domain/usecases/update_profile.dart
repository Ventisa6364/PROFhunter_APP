import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class UpdateUser {
  final AuthRepository repository;

  UpdateUser(this.repository);

  Future<AppUser> call({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
  }) {
    return repository.updateUser(
      id: id,
      email: email,
      name: name,
      companyName: companyName,
      selectedRegion: selectedRegion,
      role: role,
    );
  }
}