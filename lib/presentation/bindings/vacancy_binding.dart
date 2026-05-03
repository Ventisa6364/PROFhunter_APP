import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/datasources/vacancy_remote_data_source.dart';
import 'package:profhunterapp/data/repositories/vacancy_repository_impl.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';

class VacancyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PocketBase>(
          () => PocketBase('https://pocketbase-latest-9x81.onrender.com/'),
    );

    Get.lazyPut<VacancyRemoteDataSource>(
          () => VacancyRemoteDataSource(pb: Get.find<PocketBase>(),),
    );

    Get.lazyPut<VacancyRepository>(
          () => VacancyRepositoryImpl(
        remoteDataSource: Get.find<VacancyRemoteDataSource>(),
      ),
    );

    Get.lazyPut<GetVacancies>(
          () => GetVacancies(
        repository: Get.find<VacancyRepository>(),
      ),
    );

    Get.lazyPut<VacancyController>(
          () => VacancyController(
        getVacancies: Get.find<GetVacancies>(),
      ),
    );
  }
}