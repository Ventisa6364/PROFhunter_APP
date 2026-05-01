import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/data/repositories/auth_repository_impl.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/update_user.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBinding extends Bindings {
  final SharedPreferences prefs;

  AuthBinding(this.prefs);

  @override
  void dependencies() async {
    final pb = PocketBase(
      'https://pocketbase-latest-9x81.onrender.com/',
      authStore: AsyncAuthStore(
        initial: prefs.getString('pb_auth'),
        save: (data) async => prefs.setString('pb_auth', data),
        clear: () async => prefs.remove('pb_auth'),
      ),
    );

    Get.put<PocketBase>(pb, permanent: true);

    Get.put(AuthRemoteDataSource(pb));

    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));

    Get.lazyPut<SignIn>(() => SignIn(Get.find<AuthRepository>()));

    Get.lazyPut<SignUp>(() => SignUp(Get.find<AuthRepository>()));

    Get.lazyPut<SignOut>(() => SignOut(Get.find<AuthRepository>()));

    Get.lazyPut<UpdateUser>(() => UpdateUser(Get.find<AuthRepository>()));

    Get.lazyPut<AuthController>(
      () => AuthController(
        signInUseCase: Get.find<SignIn>(),
        signUpUseCase: Get.find<SignUp>(),
        signOutUseCase: Get.find<SignOut>(),
        updateUserUseCase: Get.find<UpdateUser>(),
      ),
    );
  }
}
