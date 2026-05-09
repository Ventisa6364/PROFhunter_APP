import 'package:profhunterapp/data/datasources/response_remote_data_source.dart';
import 'package:profhunterapp/data/models/response_model.dart';
import 'package:profhunterapp/domain/entities/response.dart';
import 'package:profhunterapp/domain/repositories/response_repository.dart';

class ResponseRepositoryImpl implements ResponseRepository {
  final ResponseRemoteDataSource remoteDataSource;

  ResponseRepositoryImpl(this.remoteDataSource);

  @override
  Future<ResponseEntity> createVacancyResponse({
    required String idVacancy,
    required String idCandidate,
  }) async {
    final data = await remoteDataSource.createVacancyResponse(
      idVacancy: idVacancy,
      idCandidate: idCandidate,
    );

    if (data == null) {
      throw Exception('Не удалось создать отклик. Возможно, Вы уже откликнулись.');
    }


    return ResponseModel.fromJson(data);
  }

  @override
  Future<List<ResponseEntity>> getUserResponses({required String idCandidate,}) async{
    return await remoteDataSource.getUserResponses(idCandidate: idCandidate);
  }
}
