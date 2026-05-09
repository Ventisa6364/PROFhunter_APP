class Message {
  final String id;
  final String text;
  final String senderId;
  final String chatId;
  final DateTime created;

  Message({
    required this.id,
    required this.text,
    required this.senderId,
    required this.chatId,
    required this.created,
  });
}