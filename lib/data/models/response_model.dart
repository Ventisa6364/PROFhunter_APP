import 'package:profhunterapp/domain/entities/response.dart';

class ResponseModel extends ResponseEntity {
  ResponseModel({
    required super.id,
    required super.idCandidate,
    required super.idVacancy,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> map) {
    return ResponseModel(
      id: map['id'] ?? '',
      idVacancy: map['idVacancy'] ?? '',
      idCandidate: map['idCandidate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'idVacancy': idVacancy, 'idCandidate': idCandidate};
  }
}