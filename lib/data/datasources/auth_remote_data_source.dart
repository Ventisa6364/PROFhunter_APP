import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource {
  late final PocketBase pb;

  Future<void> initPocketBase() async {
    final prefs = await SharedPreferences.getInstance();

    pb = PocketBase(
      'http://10.0.2.2:8090',
      authStore: AsyncAuthStore(
        initial: prefs.getString('pb_auth'),
        save: (data) async => prefs.setString('pb_auth', data),
        clear: () async => prefs.remove('pb_auth'),
      ),
    );

    if (pb.authStore.isValid) {
      try {
        await pb.collection('users').authRefresh();
      } catch (_) {
        pb.authStore.clear();
      }
    }
  }

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
