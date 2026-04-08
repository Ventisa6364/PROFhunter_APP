import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/auth/app_user.dart';
import 'package:profhunterapp/auth/auth_repository.dart';

class PocketBaseAuthRepository implements AuthRepository {
  final PocketBase pb;

  PocketBaseAuthRepository(this.pb);

  @override
  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
  }) async {
    final record = await pb.collection('users').create(
      body: {
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'name': name,
        'companyName': companyName,
        'selectedRegion': selectedRegion,
      },
    );

    return AppUser(
      id: record.id,
      email: record.data['email'] as String? ?? '',
      name: record.data['name'] as String? ?? '',
      companyName: record.data['companyName'] as String? ?? '',
      selectedRegion: record.data['selectedRegion'] as String? ?? '',
    );
  }

  @override
  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final authData = await pb.collection('users').authWithPassword(
      email,
      password,
    );

    final user = authData.record;

    return AppUser(
      id: user.id,
      email: user.data['email'] as String? ?? '',
      name: user.data['name'] as String? ?? '',
      companyName: user.data['companyName'] as String? ?? '',
      selectedRegion: user.data['selectedRegion'] as String? ?? '',
    );
  }

  @override
  void signOut() {
    pb.authStore.clear();
  }

  @override
  bool get isLoggedIn => pb.authStore.isValid;

  @override
  AppUser? get currentUser {
    final user = pb.authStore.record;
    if (user == null) return null;

    return AppUser(
      id: user.id,
      email: user.data['email'] as String? ?? '',
      name: user.data['name'] as String? ?? '',
      companyName: user.data['companyName'] as String? ?? '',
      selectedRegion: user.data['selectedRegion'] as String? ?? '',
    );
  }
}
