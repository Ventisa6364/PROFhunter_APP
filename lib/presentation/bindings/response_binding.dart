import 'package:get/get.dart';
import 'package:profhunterapp/domain/usecases/create_vacancy_response.dart';
import 'package:profhunterapp/domain/usecases/get_user_responses.dart';
import 'package:profhunterapp/presentation/controllers/response_controller.dart';

class ResponseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponseController>(
      () => ResponseController(
        createVacancyResponseUseCase: Get.find<CreateVacancyResponse>(),
        getUserResponsesUseCase: Get.find<GetUserResponses>(),
      ),
      fenix: true,
    );
  }
}
