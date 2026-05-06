import 'package:get/get.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies_company.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';

class VacancyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VacancyController>(
      () => VacancyController(
        getVacanciesUseCase: Get.find<GetVacancies>(),
        createVacancyUseCase: Get.find<CreateVacancy>(),
        getVacanciesCompanyUseCase: Get.find<GetVacanciesCompany>(),
      ),
      fenix: true,
    );
  }
}
