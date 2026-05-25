import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/data/models/app_user_model.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

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
    final data = await remoteDataSource.signUp(
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
      name: name,
      companyName: companyName,
      selectedRegion: selectedRegion,
      role: role,
    );

    return AppUserModel.fromMap(data);
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final data = await remoteDataSource.signIn(
      email: email,
      password: password,
    );

    return AppUserModel.fromMap(data);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<AppUser> updateUser({
    required String id,
    required String email,
    required String name,
    required String companyName,
    required String selectedRegion,
    required String role,
    required String aboutMyself,
    required String aboutCompany,
    required List<String> skills,
  }) async {
    final data = await remoteDataSource.updateUser(
      id: id,
      email: email,
      name: name,
      companyName: companyName,
      selectedRegion: selectedRegion,
      role: role,
      aboutMyself: aboutMyself,
      aboutCompany: aboutCompany,
      skills: skills,
    );

    return AppUserModel.fromMap(data);
  }

  @override
  Future<AppUser> updateAvatar({
    required String userID,
    required String imagePath,
  }) async {
    final data = await remoteDataSource.updateAvatar(
      userID: userID,
      imagePath: imagePath,
    );

    return AppUserModel.fromMap(data);
  }

  @override
  Future<AppUser> getUserById({required String userID}) async {
    final data = await remoteDataSource.getUserById(userID: userID);

    return AppUserModel.fromMap(data!);
  }

  @override
  Future<AppUser> deleteAvatar({
    required String userID
  }) async {
    final data = await remoteDataSource.deleteAvatar(
      userID: userID,
    );

    return AppUserModel.fromMap(data);
  }

  @override
  AppUser? get currentUser {
    final data = remoteDataSource.currentUserMap;
    if (data == null) return null;
    return AppUserModel.fromMap(data);
  }

  @override
  bool get isLoggedIn => remoteDataSource.isLoggedIn;

  @override
  Future<AppUser?> restoreCurrentUser() async {
    final data = await remoteDataSource.restoreCurrentUser();

    if (data == null) {
      return null;
    }

    return AppUserModel.fromMap(data);
  }
}
