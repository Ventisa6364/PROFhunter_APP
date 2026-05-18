import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/delete_vacancy.dart';
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
  final DeleteVacancy deleteVacancyUseCase;

  VacancyController({
    required this.getVacanciesUseCase,
    required this.createVacancyUseCase,
    required this.getVacanciesCompanyUseCase,
    required this.getVacancyByIdUseCase,
    required this.editVacancyUseCase,
    required this.deleteVacancyUseCase,
  });

  /// Все вакансии с сервера
  final RxList<Vacancy> vacancies = <Vacancy>[].obs;

  /// Вакансии, которые отображаются после поиска/фильтрации
  final RxList<Vacancy> vacanciesView = <Vacancy>[].obs;

  /// Вакансии компании
  final RxList<Vacancy> vacanciesCompany = <Vacancy>[].obs;

  /// Вакансии компании после поиска/фильтрации, если нужно
  final RxList<Vacancy> vacanciesCompanyView = <Vacancy>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxString searchQuery = ''.obs;

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

      applyFilters();
      applyCompanyFilters();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void changeSearchQuery(String value) {
    searchQuery.value = value;
    applyFilters();
    applyCompanyFilters();
  }

  void applyFilters() {
    var filtered = vacancies.toList();

    final query = searchQuery.value.trim().toLowerCase();

    if (query.isNotEmpty) {
      filtered = filtered.where((vacancy) {
        final name = vacancy.name.toLowerCase();
        final companyName = vacancy.companyName.toLowerCase();
        final employmentType = vacancy.employmentType.toLowerCase();
        final place = vacancy.place.toLowerCase();
        final address = vacancy.address.toLowerCase();
        final salary = vacancy.salary.toLowerCase();

        return name.contains(query) ||
            companyName.contains(query) ||
            employmentType.contains(query) ||
            place.contains(query) ||
            address.contains(query) ||
            salary.contains(query);
      }).toList();
    }

    vacanciesView.assignAll(filtered);
  }

  void applyCompanyFilters() {
    var filtered = vacanciesCompany.toList();

    final query = searchQuery.value.trim().toLowerCase();

    if (query.isNotEmpty) {
      filtered = filtered.where((vacancy) {
        final name = vacancy.name.toLowerCase();
        final companyName = vacancy.companyName.toLowerCase();
        final employmentType = vacancy.employmentType.toLowerCase();
        final place = vacancy.place.toLowerCase();
        final address = vacancy.address.toLowerCase();
        final salary = vacancy.salary.toLowerCase();

        return name.contains(query) ||
            companyName.contains(query) ||
            employmentType.contains(query) ||
            place.contains(query) ||
            address.contains(query) ||
            salary.contains(query);
      }).toList();
    }

    vacanciesCompanyView.assignAll(filtered);
  }

  Future<Vacancy> getVacancyById({required String idVacancy}) async {
    try {
      final result = await getVacancyByIdUseCase(idVacancy: idVacancy);

      return result;
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    }
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

      await fetchVacancies();
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

      await fetchVacancies();
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVacancy({required String id}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await deleteVacancyUseCase(id: id);

      vacancies.removeWhere((vacancy) => vacancy.id == id);
      vacanciesCompany.removeWhere((vacancy) => vacancy.id == id);

      applyFilters();
      applyCompanyFilters();
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
