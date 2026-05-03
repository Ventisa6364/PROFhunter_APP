import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/usecases/get_vacancies.dart';

class VacancyController extends GetxController {
  final GetVacancies getVacancies;

  VacancyController({
    required this.getVacancies,
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

      final result = await getVacancies();
      vacancies.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}