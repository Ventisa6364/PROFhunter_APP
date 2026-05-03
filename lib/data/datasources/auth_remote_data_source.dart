import 'package:pocketbase/pocketbase.dart';

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

  Future<Map<String, dynamic>> updateUser({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
    required String avatar,
    required String aboutMyself,
    required String aboutCompany,
    required List<String> skills,
  }) async {
    final record = await pb
        .collection('users')
        .update(
      id,
      body: {
        'email': email,
        'name': name,
        'companyName': companyName,
        'selectedRegion': selectedRegion,
        'role': role,
        'avatar': avatar,
        'aboutMyself': aboutMyself,
        'aboutCompany': aboutCompany,
        'skills': skills,
      },
    );

    pb.authStore.save(pb.authStore.token, record);

    return {'id': record.id, ...record.data};
  }

  Future<void> signOut() async {
    pb.authStore.clear();
  }

  Map<String, dynamic>? get currentUserMap {
    final user = pb.authStore.record;
    if (user == null) return null;

    return {
      'id': user.id,
      'email': user.getStringValue('email'),
      ...user.data,
    };
  }

  bool get isLoggedIn => pb.authStore.isValid;

  Future<Map<String, dynamic>?> restoreCurrentUser() async {
    if (!isLoggedIn) return null;

    try {
      await pb.collection('users').authRefresh();

      return currentUserMap;
    }
    catch (e) {
      pb.authStore.clear();

      return null;
    }
  }
}
