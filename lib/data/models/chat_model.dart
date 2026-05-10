import 'package:profhunterapp/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.idCompany,
    required super.idVacancy,
    required super.idCandidate,
    required super.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      idCompany: map['idCompany'] ?? '',
      idVacancy: map['idVacancy'] ?? '',
      idCandidate: map['idCandidate'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idCompany': idCompany,
      'idVacancy': idVacancy,
      'idCandidate': idCandidate,
    };
  }
}
