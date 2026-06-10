import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/domain/entities/chat_view_data.dart';
import 'package:profhunterapp/domain/entities/message.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.getMessageFromChat(chatId: widget.item.chat.id);
      chatController.subscribeMessages(widget.item.chat.id);
    });
  }

  @override
  void dispose() {
    chatController.unsubscribeMessages();
    super.dispose();
  }

  List<dynamic> createListWithDateAndMessages(List<Message> messages) {
    List<dynamic> items = [];
    DateTime? lastDate;

    for (final message in messages) {
      final created = message.created ?? DateTime.now();
      final messageDate = DateTime(created.year, created.month, created.day);

      if (lastDate == null || lastDate != messageDate) {
        items.add(messageDate);
        lastDate = messageDate;
      }

      items.add(message);
    }
    return items;
  }

  String formatMessageTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  String formatChatDate(DateTime dateTime) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return 'Сегодня';
    }

    if (messageDate == yesterday) {
      return 'Вчера';
    }

    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];

    final day = dateTime.day;
    final month = months[dateTime.month - 1];

    if (dateTime.year == now.year) {
      return '$day $month';
    }

    return '$day $month ${dateTime.year}';
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
        onPressed: () {
          chatController.getUserChats(
            userID: authController.user.value!.id,
            userRole: authController.user.value!.role,
          );
          _getBack();
        },
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

              final chatItems = createListWithDateAndMessages(
                chatController.messages,
              );

              return ListView.builder(
                padding: .all(12.r),
                itemCount: chatItems.length,
                itemBuilder: (context, index) {
                  final item = chatItems[index];
                  if (item is DateTime) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.palette.block,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          formatChatDate(item),
                          style: CustomStyles.nunitoMedium11.copyWith(
                            color: theme.palette.textSecondary,
                          ),
                        ),
                      ),
                    );
                  }

                  final isMine = item.senderId == authController.user.value!.id;

                  return Padding(
                    padding: .only(bottom: 6.h),
                    child: MessageWidget(
                      isMine: isMine,
                      textMessage: item.textMessage,
                      created: item.created ?? DateTime.now(),
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
