import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_view_data.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';
import 'package:profhunterapp/presentation/controllers/vacancy_controller.dart';
import 'package:profhunterapp/presentation/pages/utils/main_screen.dart';
import 'package:profhunteruikit/uikit.dart';

class ChatPage extends StatefulWidget {
  final ChatViewData item;

  const ChatPage({super.key, required this.item});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = Get.find<ChatController>();
  final authController = Get.find<AuthController>();
  final vacancyController = Get.find<VacancyController>();
  final messageEditController = TextEditingController();

  bool isLoadingCompany = true;

  @override
  void initState() {
    super.initState();
    chatController.getMessageFromChat(chatId: widget.item.chat.id);
    chatController.subscribeMessages(widget.item.chat.id);
  }

  @override
  void dispose() {
    chatController.unsubscribeMessages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBarWidget(
        title: widget.item.companyName,
        subtitle: widget.item.vacancyName,
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoadingMessages.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (chatController.messages.isEmpty) {
                return const Center(child: Text('Сообщений пока нет'));
              }

              return ListView.builder(
                padding: .all(12.r),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];

                  final isMine =
                      message.senderId == authController.user.value!.id;

                  return Padding(
                    padding: .only(bottom: 6.h),
                    child: MessageWidget(
                      isMine: isMine,
                      textMessage: message.textMessage,
                      created: message.created ?? DateTime.now(),
                    ),
                  );
                },
              );
            }),
          ),
          MessageInputWidget(
            controller: messageEditController,
            onTap: () async {
              await chatController.sendMessage(
                senderId: authController.user.value!.id,
                chatId: widget.item.chat.id,
                textMessage: messageEditController.text,
              );

              messageEditController.text = '';
            },
          ),
        ],
      ),
    );
  }

  void _getBack() {
    Get.offAll(() => MainScreen(initialIndex: 1));
  }
}
