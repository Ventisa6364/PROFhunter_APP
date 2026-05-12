import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/controllers/chat_controller.dart';
import 'package:profhunteruikit/uikit.dart';

class UserChatsPage extends StatefulWidget {
  const UserChatsPage({super.key});

  @override
  State<UserChatsPage> createState() => _UserChatsPageState();
}

class _UserChatsPageState extends State<UserChatsPage> {
  final chatController = Get.find<ChatController>();
  final authController = Get.find<AuthController>();

  late Worker userWorker;

  @override
  void initState() {
    super.initState();
    userWorker = ever(authController.user, (user) {
      if (user == null) return;

      chatController.getUserChats(userID: user.id);
    });

    final user = authController.user.value;
    if (user != null) {
      chatController.getUserChats(userID: user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Чаты'),
      backgroundColor: theme.palette.background,
      body: Obx(() {
        // if (chatController.isLoading.value) {}

        if (!(chatController.isLoading.value) &&
            chatController.chatsView.isEmpty) {
          return const Center(child: Text('Чатов пока нет'));
        }

        return ListView.builder(
          itemCount: chatController.chatsView.length,
          itemBuilder: (context, index) {
            final item = chatController.chatsView[index];

            return ChatWidget(
              companionName: item.companyName,
              lastMessage: item.chat.lastMessage,
              vacancyName: item.vacancyName,
              onTap: () {
                Get.toNamed('/chat', arguments: item);
              },
            );
          },
        );
      }),
    );
  }
}
