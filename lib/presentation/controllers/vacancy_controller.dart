import 'package:get/get.dart';
import 'package:profhunterapp/data/models/vacancy_model.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/edit_vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies_company.dart';
import 'package:profhunterapp/domain/usecases/get_vacancy_by_id.dart';

class VacancyController extends GetxController {
  final GetVacancies getVacanciesUseCase;
  final GetVacanciesCompany getVacanciesCompanyUseCase;
  final GetVacancyById getVacancyByIdUseCase;
  final CreateVacancy createVacancyUseCase;
  final EditVacancy editVacancyUseCase;

  VacancyController({
    required this.getVacanciesUseCase,
    required this.createVacancyUseCase,
    required this.getVacanciesCompanyUseCase,
    required this.getVacancyByIdUseCase,
    required this.editVacancyUseCase,
  });

  final RxList<Vacancy> vacancies = <Vacancy>[].obs;
  final RxList<Vacancy> vacanciesCompany = <Vacancy>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVacancies();
  }

  Future<void> fetchVacancies() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getVacanciesUseCase();
      vacancies.assignAll(result);

      final resultForCompany = await getVacanciesCompanyUseCase();
      vacanciesCompany.assignAll(resultForCompany);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Vacancy> getVacancyById({required String idVacancy}) async {
    try {
      final result = await getVacancyByIdUseCase(idVacancy: idVacancy);

      return result;
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {}
  }

  Future<void> createVacancy({
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required String userID,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await createVacancyUseCase(
        name: name,
        salary: salary,
        companyName: companyName,
        employmentType: employmentType,
        place: place,
        address: address,
        userID: userID,
        duties: duties,
        requirements: requirements,
        conditions: conditions,
        contacts: contacts,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editVacancy({
    required String id,
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required String userID,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await editVacancyUseCase(
        id: id,
        name: name,
        salary: salary,
        companyName: companyName,
        employmentType: employmentType,
        place: place,
        address: address,
        userID: userID,
        duties: duties,
        requirements: requirements,
        conditions: conditions,
        contacts: contacts,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
