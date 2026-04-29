import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  final PocketBase pb;
  AuthRemoteDataSource(this.pb);

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
  }) async {
    final record = await pb
        .collection('users')
        .create(
          body: {
            'email': email,
            'password': password,
            'passwordConfirm': passwordConfirm,
            'name': name,
            'companyName': companyName,
            'selectedRegion': selectedRegion,
            'role': role,
          },
        );

    return {'id': record.id, ...record.data};
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(email, password);

    return {'id': authData.record.id, ...authData.record.data};
  }

  Future<void> signOut() async {
    pb.authStore.clear();
  }

  Map<String, dynamic>? get currentUserMap {
    final user = pb.authStore.record;
    if (user == null) return null;

    return {
      'id': user.id,
      ...user.data,
    };
  }

  bool get isLoggedIn => pb.authStore.isValid;
}
