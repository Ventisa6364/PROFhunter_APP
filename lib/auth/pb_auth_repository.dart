import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/auth/app_user.dart';
import 'package:profhunterapp/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseAuthRepository implements AuthRepository {
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

  @override
  Future<AppUser> signUp({
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

    return AppUser(
      id: record.id,
      email: record.data['email'] as String? ?? '',
      name: record.data['name'] as String? ?? '',
      companyName: record.data['companyName'] as String? ?? '',
      selectedRegion: record.data['selectedRegion'] as String? ?? '',
      role: record.data['role'] as String? ?? '',
      avatar: '',
      aboutMyself: '',
      aboutCompany: '',
      skills: [],
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
      email: user.data['email'] as String? ?? '',
      name: user.data['name'] as String? ?? '',
      companyName: user.data['companyName'] as String? ?? '',
      selectedRegion: user.data['selectedRegion'] as String? ?? '',
      role: user.data['role'] as String? ?? '',
      avatar: '',
      aboutMyself: '',
      aboutCompany: '',
      skills: [],
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
      role: user.data['role'] as String? ?? '',
      avatar: '',
      aboutMyself: '',
      aboutCompany: '',
      skills: [],
    );
  }
}
