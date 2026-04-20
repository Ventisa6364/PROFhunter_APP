import 'package:get/get.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/data/repositories/auth_repository_impl.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<AuthRemoteDataSource>(() async {
      final ds = AuthRemoteDataSource();
      await ds.initPocketBase();
      return ds;
    });

    Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(Get.find()),
    );

    Get.lazyPut<SignIn>(
          () => SignIn(Get.find<AuthRepository>()),
    );

    Get.lazyPut<SignUp>(
          () => SignUp(Get.find<AuthRepository>()),
    );

    Get.lazyPut<SignOut>(
          () => SignOut(Get.find<AuthRepository>()),
    );

    Get.lazyPut<AuthController>(
          () => AuthController(
        signInUseCase: Get.find<SignIn>(),
        signUpUseCase: Get.find<SignUp>(),
        signOutUseCase: Get.find<SignOut>(),
      ),
    );
  }
}
