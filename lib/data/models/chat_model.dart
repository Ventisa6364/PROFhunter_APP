import 'package:profhunterapp/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.id,
    required super.idCompany,
    required super.idCandidate,
  });

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      idCompany: map['idCompany'] ?? '',
      idCandidate: map['idCandidate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'idCompany': idCompany, 'idCandidate': idCandidate};
  }
}
