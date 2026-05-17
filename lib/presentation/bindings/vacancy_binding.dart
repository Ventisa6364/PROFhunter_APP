import 'package:get/get.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/edit_vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies_company.dart';
import 'package:profhunterapp/domain/usecases/get_vacancy_by_id.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';

class VacancyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VacancyController>(
      () => VacancyController(
        getVacanciesUseCase: Get.find<GetVacancies>(),
        getVacanciesCompanyUseCase: Get.find<GetVacanciesCompany>(),
        getVacancyByIdUseCase: Get.find<GetVacancyById>(),
        createVacancyUseCase: Get.find<CreateVacancy>(),
        editVacancyUseCase: Get.find<EditVacancy>(),
      ),
      fenix: true,
    );
  }
}
