import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/data/models/vacancy_model.dart';

class VacancyRemoteDataSource {
  final PocketBase pb;

  VacancyRemoteDataSource({required this.pb});

  Future<List<VacancyModel>> getVacancies() async {
    final result = await pb.collection('vacancy').getList(
      page: 1,
      perPage: 50,
      sort: '-created',
    );

    return result.items.map((record) {
      return VacancyModel.fromJson({
        'id': record.id,
        ...record.data,
      });
    }).toList();
  }
}
