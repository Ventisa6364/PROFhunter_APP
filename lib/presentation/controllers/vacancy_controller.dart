import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';

class VacancyController extends GetxController {
  final GetVacancies getVacanciesUseCase;
  final CreateVacancy createVacancyUseCase;

  VacancyController({
    required this.getVacanciesUseCase, required this.createVacancyUseCase,
  });

  final RxList<Vacancy> vacancies = <Vacancy>[].obs;
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
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createVacancy({required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await createVacancyUseCase(name: name,
        salary: salary,
        companyName: companyName,
        employmentType: employmentType,
        place: place,
        address: address,
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