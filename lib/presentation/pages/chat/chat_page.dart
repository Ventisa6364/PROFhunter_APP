import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/data/models/chat_model.dart';
import 'package:profhunterapp/domain/entities/message.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = Get.find<ChatController>();
  final authController = Get.find<AuthController>();
  final messageEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBarWidget(
        title: widget.chat.idCompany,
        iconBtn: Icons.arrow_back_rounded,
        onPressed: _getBack,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: 16.h, vertical: 0.w),
              child: FutureBuilder<List<Message>>(
                future: chatController.getMessageFromChat(
                  chatId: widget.chat.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox();
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Ошибка загрузки сообщений'),
                    );
                  }

                  final messages = snapshot.data ?? [];

                  if (messages.isEmpty) {
                    return const SizedBox();
                  }

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      return Padding(
                        padding: .only(bottom: 6.h),
                        child: MessageWidget(
                          isMine:
                              message.senderId ==
                              authController.user.value?.id,
                          textMessage: message.textMessage,
                          created: message.created ?? DateTime.now(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          MessageInputWidget(
            controller: messageEditController,
            onTap: () async {
              await chatController.sendMessage(
                senderId: authController.user.value!.id,
                chatId: widget.chat.id,
                textMessage: messageEditController.text,
              );

              messageEditController.text = '';

              setState(() {

              });
            },
          ),
        ],
      ),
    );
  }

  void _getBack() => Get.back();
}
