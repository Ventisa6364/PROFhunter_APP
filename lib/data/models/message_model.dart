import 'package:profhunterapp/domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.textMessage,
    required super.senderId,
    required super.chatId,
    required super.created,
    required super.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      chatId: map['chatId'] ?? '',
      textMessage: map['textMessage'] ?? '',
      created: map['created'] != null? DateTime.parse(map['created']) : null,
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'chatId': chatId,
      'textMessage': textMessage,
      if (created != null) 'created': created!.toUtc().toIso8601String(),
      'isRead': isRead,
    };
  }
}
