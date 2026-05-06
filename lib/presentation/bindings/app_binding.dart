import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/data/datasources/vacancy_remote_data_source.dart';
import 'package:profhunterapp/data/repositories/auth_repository_impl.dart';
import 'package:profhunterapp/data/repositories/vacancy_repository_impl.dart';
import 'package:profhunterapp/domain/repositories/auth_repository.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies_company.dart';
import 'package:profhunterapp/domain/usecases/restore_current_user.dart';
import 'package:profhunterapp/domain/usecases/sign_in.dart';
import 'package:profhunterapp/domain/usecases/sign_out.dart';
import 'package:profhunterapp/domain/usecases/sign_up.dart';
import 'package:profhunterapp/domain/usecases/update_user.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding extends Bindings {
  final SharedPreferences prefs;

  AppBinding(this.prefs);

  @override
  void dependencies() {
    final pb = PocketBase(
      'https://pocketbase-latest-9x81.onrender.com/',
      authStore: AsyncAuthStore(
        initial: prefs.getString('pb_auth'),
        save: (data) async => prefs.setString('pb_auth', data),
        clear: () async => prefs.remove('pb_auth'),
      ),
    );

    Get.put<PocketBase>(pb, permanent: true);

    // Auth
    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSource(pb),
      permanent: true,
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<SignIn>(() => SignIn(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut<SignUp>(() => SignUp(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut<SignOut>(() => SignOut(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut<UpdateUser>(() => UpdateUser(Get.find<AuthRepository>()), fenix: true);

    Get.put<RestoreCurrentUser>(
      RestoreCurrentUser(Get.find<AuthRepository>()),
      permanent: true,
    );

    Get.put<AuthController>(
      AuthController(
        signInUseCase: Get.find<SignIn>(),
        signUpUseCase: Get.find<SignUp>(),
        signOutUseCase: Get.find<SignOut>(),
        updateUserUseCase: Get.find<UpdateUser>(),
        restoreCurrentUserUseCase: Get.find<RestoreCurrentUser>(),
      ),
      permanent: true,
    );

    // Vacancies dependencies
    Get.put<VacancyRemoteDataSource>(
      VacancyRemoteDataSource(pb: Get.find<PocketBase>()),
      permanent: true,
    );

    Get.put<VacancyRepository>(
      VacancyRepositoryImpl(
        remoteDataSource: Get.find<VacancyRemoteDataSource>(),
      ),
      permanent: true,
    );

    Get.lazyPut<GetVacancies>(
          () => GetVacancies(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    Get.lazyPut<CreateVacancy>(
          () => CreateVacancy(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );

    Get.lazyPut<GetVacanciesCompany>(
          () => GetVacanciesCompany(repository: Get.find<VacancyRepository>()),
      fenix: true,
    );
  }
}