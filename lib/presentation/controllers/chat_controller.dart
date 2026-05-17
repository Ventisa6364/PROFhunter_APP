import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_entity.dart';
import 'package:profhunterapp/domain/entities/chat_view_data.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/domain/usecases/get_chat.dart';
import 'package:profhunterapp/domain/usecases/get_message_from_chat.dart';
import 'package:profhunterapp/domain/usecases/get_user_chats.dart';
import 'package:profhunterapp/domain/usecases/insubscribe_message.dart';
import 'package:profhunterapp/domain/usecases/send_message.dart';
import 'package:profhunterapp/domain/usecases/subscribe_message.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';

class ChatController extends GetxController {
  final GetChat getChatUseCase;
  final SendMessage sendMessageUseCase;
  final GetMessageFromChat getMessageFromChatUseCase;
  final SubscribeMessages subscribeMessagesUseCase;
  final UnsubscribeMessages unsubscribeMessagesUseCase;
  final GetUserChats getUserChatsUseCase;

  ChatController({
    required this.getChatUseCase,
    required this.sendMessageUseCase,
    required this.getMessageFromChatUseCase,
    required this.subscribeMessagesUseCase,
    required this.unsubscribeMessagesUseCase,
    required this.getUserChatsUseCase,
  });

  final authController = Get.find<AuthController>();
  final vacancyController = Get.find<VacancyController>();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMessages = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxString errorMessage = ''.obs;

  final messages = <Message>[].obs;

  final Rxn<ChatEntity> chat = Rxn<ChatEntity>();
  final RxList<ChatEntity> chats = <ChatEntity>[].obs;

  final chatsView = <ChatViewData>[].obs;

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

      final index = chatsView.indexWhere((item) => item.chat.id == chatId);

      if (index != -1) {
        final oldItem = chatsView[index];

        chatsView[index] = ChatViewData(
          chat: oldItem.chat.copyWith(lastMessage: textMessage),
          companyName: oldItem.companyName,
          vacancyName: oldItem.vacancyName,
        );

        chatsView.refresh();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isSendingMessage.value = false;
    }
  }

  Future<ChatViewData> getChat({
    required String idCompany,
    required String idVacancy,
    required String idCandidate,
    required String userRole,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final chat = await getChatUseCase(
        idCompany: idCompany,
        idVacancy: idVacancy,
        idCandidate: idCandidate,
      );

      final companion = await authController.getUserById(
        userID: userRole == 'candidate' ? chat.idCompany : chat.idCandidate,
      );

      final vacancy = await vacancyController.getVacancyById(
        idVacancy: chat.idVacancy,
      );

      return ChatViewData(
        chat: chat,
        companyName: userRole == 'candidate'
            ? companion.companyName
            : companion.name,
        vacancyName: vacancy.name,
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

  Future<void> getUserChats({
    required String userID,
    required String userRole,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getUserChatsUseCase(userID: userID);

      chats.assignAll(result);

      final enrichedChats = await Future.wait(
        result.map((chat) async {
          final user = await authController.getUserById(
            userID: (userRole == 'candidate')
                ? chat.idCompany
                : chat.idCandidate,
          );

          final vacancy = await vacancyController.getVacancyById(
            idVacancy: chat.idVacancy,
          );

          return ChatViewData(
            chat: chat,
            companyName: (userRole == 'candidate')
                ? user.companyName
                : user.name,
            vacancyName: vacancy.name,
          );
        }),
      );

      chatsView.assignAll(enrichedChats);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
