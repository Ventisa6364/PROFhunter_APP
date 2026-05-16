import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/response_view_data.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy_response.dart';
import 'package:profhunterapp/domain/entities/response.dart';
import 'package:profhunterapp/domain/usecases/get_company_responses.dart';
import 'package:profhunterapp/domain/usecases/get_user_responses.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class ResponseController extends GetxController {
  final CreateVacancyResponse createVacancyResponseUseCase;
  final GetUserResponses getUserResponsesUseCase;
  final GetCompanyResponses getCompanyResponsesUseCase;

  ResponseController({
    required this.createVacancyResponseUseCase,
    required this.getUserResponsesUseCase,
    required this.getCompanyResponsesUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<ResponseEntity> response = Rxn<ResponseEntity>();
  final RxList<ResponseEntity> responses = <ResponseEntity>[].obs;
  final RxList<ResponseViewData> responsesCompany = <ResponseViewData>[].obs;

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    if (authController.user.value?.id.isNotEmpty == true) {
      fetchResponse(idCandidate: authController.user.value!.id);
      fetchResponsesForCompany();
    }
  }

  Future<void> createVacancyResponse({
    required String idCandidate,
    required String idVacancy,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await createVacancyResponseUseCase(
        idCandidate: idCandidate,
        idVacancy: idVacancy,
      );

      final context = Get.context;

      if (context != null) {
        final theme = CustomTheme.of(context);

        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Успешно',
            style: CustomStyles.nunitoMedium22.copyWith(
              color: theme.palette.text,
            ),
          ),
          messageText: Text(
            'Отклик отправлен',
            style: CustomStyles.nunitoMedium16.copyWith(
              color: theme.palette.textSecondary,
            ),
          ),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');

      Get.snackbar(
        '',
        '',
        titleText: Text(
          'Ошибка',
          style: CustomStyles.nunitoMedium22.copyWith(
            color: CustomTheme(palette: DarkPalette()).palette.text,
          ),
        ),
        messageText: Text(
          errorMessage.value,
          style: CustomStyles.nunitoMedium16.copyWith(
            color: CustomTheme(palette: DarkPalette()).palette.textSecondary,
          ),
        ),
      );
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchResponse({required String idCandidate}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getUserResponsesUseCase(idCandidate: idCandidate);
      responses.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchResponsesForCompany() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getCompanyResponsesUseCase();
      responsesCompany.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
