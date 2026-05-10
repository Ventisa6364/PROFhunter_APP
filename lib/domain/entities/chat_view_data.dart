import 'package:profhunterapp/domain/entities/chat_entity.dart';

class ChatViewData {
  final ChatEntity chat;
  final String companyName;
  final String vacancyName;

  ChatViewData({
    required this.chat,
    required this.companyName,
    required this.vacancyName,
  });
}