import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/vacancy_model.dart';

class VacancyRemoteDataSource {
  final PocketBase pb;

  VacancyRemoteDataSource({required this.pb});

  Future<List<VacancyModel>> getVacancies() async {
    final result = await pb
        .collection('vacancy')
        .getList(page: 1, perPage: 50, sort: '-created');

    return result.items.map((record) {
      return VacancyModel.fromJson({'id': record.id, ...record.data});
    }).toList();
  }

  Future<VacancyModel> getVacancyById({required String idVacancy}) async {
    final result = await pb.collection('vacancy').getOne(idVacancy);


    return VacancyModel.fromJson({'id': result.id, ...result.data});
  }

Future<List<VacancyModel>> getVacanciesCompany() async {
  final result = await pb
      .collection('vacancy')
      .getList(
    page: 1,
    perPage: 50,
    sort: '-created',
    filter: 'userID = "${pb.authStore.record?.id}"',
  );

  return result.items.map((record) {
    return VacancyModel.fromJson({'id': record.id, ...record.data});
  }).toList();
}

Future<Map<String, dynamic>> createVacancy({
  required String name,
  required String salary,
  required String companyName,
  required String employmentType,
  required String place,
  required String address,
  required List<String> duties,
  required List<String> requirements,
  required List<String> conditions,
  required Map<String, dynamic> contacts,
}) async {
  final record = await pb
      .collection('vacancy')
      .create(
    body: {
      'salary': salary,
      'name': name,
      'companyName': companyName,
      'employmentType': employmentType,
      'place': place,
      'address': address,
      'duties': duties,
      'requirements': requirements,
      'conditions': conditions,
      'contacts': contacts,
      'userID': pb.authStore.record?.id,
    },
  );

  return {'id': record.id, ...record.data};
}}
