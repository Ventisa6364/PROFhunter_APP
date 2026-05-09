import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/usecases/create_chat.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';

class ChatController extends GetxController {
  final CreateChat createChatUseCase;
  final SendMessage sendMessageUseCase;

  ChatController({
    required this.createChatUseCase,
    required this.sendMessageUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<Message> message = Rxn<Message>();
  final Rxn<ChatEntity> chat = Rxn<ChatEntity>();

  Future<void> sendMessage({
    required String senderId,
    required String chatId,
    required String textMessage,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      message.value = await sendMessageUseCase(
        chatId: chatId,
        senderId: senderId,
        textMessage: textMessage,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createChat({
    required String idCompany,
    required String idCandidate,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      chat.value = await createChatUseCase(
        idCompany: idCompany,
        idCandidate: idCandidate,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
