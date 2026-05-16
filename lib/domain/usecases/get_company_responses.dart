import 'package:profhunterapp/domain/entities/response_view_data.dart';
import 'package:profhunterapp/domain/repositories/response_repository.dart';

class GetCompanyResponses {
  final ResponseRepository repository;

  GetCompanyResponses(this.repository);

  Future<List<ResponseViewData>> call() async {
    return await repository.getCompanyResponses();
  }
}