import 'package:profhunterapp/data/models/chat_model.dart';

class ChatEntity {
  final String id;
  final String idCompany;
  final String idVacancy;
  final String idCandidate;
  final String lastMessage;

  ChatEntity({
    required this.id,
    required this.idCompany,
    required this.idVacancy,
    required this.idCandidate,
    required this.lastMessage,
  });

  ChatModel copyWith({String? lastMessage}) {
    return ChatModel(
      id: id,
      idCompany: idCompany,
      idVacancy: idVacancy,
      lastMessage: lastMessage ?? this.lastMessage,
      idCandidate: idCandidate,
    );
  }
}
