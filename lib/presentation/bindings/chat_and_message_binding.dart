import 'package:get/get.dart';
import 'package:profhunterapp/domain/usecases/create_chat.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';

class ChatAndMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(
        createChatUseCase: Get.find<CreateChat>(),
        sendMessageUseCase: Get.find<SendMessage>(),
      ),
      fenix: true,
    );
  }
}
