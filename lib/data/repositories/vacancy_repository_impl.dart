import 'package:profhunterapp/data/datasources/vacancy_remote_data_source.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class VacancyRepositoryImpl implements VacancyRepository {
  final VacancyRemoteDataSource remoteDataSource;

  VacancyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Vacancy>> getVacancies() async {
    return await remoteDataSource.getVacancies();
  }

}