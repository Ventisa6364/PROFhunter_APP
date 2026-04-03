import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/auth/app_user.dart';
import 'package:profhunterapp/auth/auth_repository.dart';

class PocketBaseAuthRepository implements AuthRepository {
  final PocketBase pb;

  PocketBaseAuthRepository(this.pb);

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
  }) async {
    final record = await pb
        .collection('users')
        .create(
          body: {
            'email': email,
            'password': password,
            'passwordConfirm': passwordConfirm,
            'name': name,
            'selectedRegion': selectedRegion,
            'companyName': companyName,
          },
        );

    return AppUser(
      id: record.id,
      email: record.data['email'],
      name: record.data['name'],
    );
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(email, password);

    final user = authData.record;

    return AppUser(
      id: user.id,
      email: user.data['email'],
      name: user.data['name'],
    );
  }

  @override
  AppUser? get currentUser {
    final user = pb.authStore.record;

    if (user == null) return null;

    return AppUser(
      id: user.id,
      email: user.data['email'],
      name: user.data['name'],
    );
  }

  @override
  void signOut() {
    pb.authStore.clear();
  }

  @override
  bool get isLoggedIn => pb.authStore.isValid;
}
