import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/domain/entities/app_user.dart';
import 'package:profhunterapp/domain/entities/response.dart';

class ResponseViewData {
  final String id;
  final String vacancyTitle;
  final String candidateId;
  final String vacancyId;
  final String candidateName;
  final String candidateEmail;
  final DateTime created;

  ResponseViewData({
    required this.id,
    required this.vacancyTitle,
    required this.candidateName,
    required this.candidateEmail,
    required this.created,
    required this.candidateId,
    required this.vacancyId,
  });

  factory ResponseViewData.fromRecord(RecordModel record) {
    final vacancy = record.get<RecordModel?>('expand.idVacancy');
    final candidate = record.get<RecordModel?>('expand.idCandidate');

    return ResponseViewData(
      id: record.id,

      vacancyId: vacancy?.id ?? record.getStringValue('idVacancy'),
      candidateId: candidate?.id ?? record.getStringValue('idCandidate'),

      vacancyTitle: vacancy?.getStringValue('name') ?? 'Без названия',
      candidateName: candidate?.getStringValue('name') ?? 'Без имени',
      candidateEmail: candidate?.getStringValue('email') ?? 'Email не указан',
      created: DateTime.tryParse(record.created) ?? DateTime.now(),
    );
  }
}
