import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/usecases/get_chat.dart';
import 'package:profhunterapp/domain/usecases/get_message_from_chat.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';

class ChatController extends GetxController {
  final GetChat getChatUseCase;
  final SendMessage sendMessageUseCase;
  final GetMessageFromChat getMessageFromChatUseCase;

  ChatController({
    required this.getChatUseCase,
    required this.sendMessageUseCase,
    required this.getMessageFromChatUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rxn<Message> message = Rxn<Message>();
  final RxList<Message> messages = <Message>[].obs;
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

  Future<ChatEntity> getChat({
    required String idCompany,
    required String idCandidate,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      return await getChatUseCase(
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

  Future<List<Message>> getMessageFromChat({required String chatId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      return await getMessageFromChatUseCase(chatId: chatId);
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
