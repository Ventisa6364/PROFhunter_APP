import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/usecases/get_chat.dart';
import 'package:profhunterapp/domain/usecases/get_message_from_chat.dart';
import 'package:profhunterapp/domain/usecases/insubscribe_message.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';
import 'package:profhunterapp/domain/usecases/subscribe_message.dart';

class ChatController extends GetxController {
  final GetChat getChatUseCase;
  final SendMessage sendMessageUseCase;
  final GetMessageFromChat getMessageFromChatUseCase;
  final SubscribeMessages subscribeMessagesUseCase;
  final UnsubscribeMessages unsubscribeMessagesUseCase;

  ChatController({
    required this.getChatUseCase,
    required this.sendMessageUseCase,
    required this.getMessageFromChatUseCase,
    required this.subscribeMessagesUseCase,
    required this.unsubscribeMessagesUseCase,
  });

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMessages = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxString errorMessage = ''.obs;

  final messages = <Message>[].obs;

  final Rxn<ChatEntity> chat = Rxn<ChatEntity>();

  Future<void> sendMessage({
    required String senderId,
    required String chatId,
    required String textMessage,
  }) async {
    try {
      isSendingMessage.value = true;
      errorMessage.value = '';

      await sendMessageUseCase(
        chatId: chatId,
        senderId: senderId,
        textMessage: textMessage,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isSendingMessage.value = false;
    }
  }

  Future<ChatEntity> getChat({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      return await getChatUseCase(
        idCompany: idCompany,
        idVacancy: idVacancy,
        idCandidate: idCandidate,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMessageFromChat({required String chatId}) async {
    try {
      isLoadingMessages.value = true;
      errorMessage.value = '';

      final result = await getMessageFromChatUseCase(chatId: chatId);
      messages.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoadingMessages.value = false;
    }
  }

  Future<void> subscribeMessages(String chatId) async {
    await subscribeMessagesUseCase(
      chatId: chatId,
      onMessage: (message) {
        if (!messages.any((m) => m.id == message.id)) {
          messages.add(message);
        }
      },
    );
  }

  Future<void> unsubscribeMessages() async {
    await unsubscribeMessagesUseCase();
  }
}
