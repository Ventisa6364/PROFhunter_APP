class Message {
  final String id;
  final String textMessage;
  final String senderId;
  final String chatId;
  final DateTime? created;
  final bool isRead;

  Message({
    required this.id,
    required this.textMessage,
    required this.senderId,
    required this.chatId,
    required this.created,
    required this.isRead,
  });
}
