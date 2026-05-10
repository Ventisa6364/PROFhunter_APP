import 'package:get/get.dart';
import 'package:profhunterapp/domain/usecases/get_chat.dart';
import 'package:profhunterapp/domain/usecases/get_message_from_chat.dart';
import 'package:profhunterapp/domain/usecases/insubscribe_message.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';
import 'package:profhunterapp/domain/usecases/subscribe_message.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';

class ChatAndMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(
        getChatUseCase: Get.find<GetChat>(),
        sendMessageUseCase: Get.find<SendMessage>(),
        getMessageFromChatUseCase: Get.find<GetMessageFromChat>(),
        subscribeMessagesUseCase: Get.find<SubscribeMessages>(),
        unsubscribeMessagesUseCase: Get.find<UnsubscribeMessages>(),
      ),
      fenix: true,
    );
  }
}
