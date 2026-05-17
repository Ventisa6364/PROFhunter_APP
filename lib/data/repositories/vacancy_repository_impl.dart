import 'package:profhunterapp/data/datasources/vacancy_remote_data_source.dart';
import 'package:profhunterapp/data/models/vacancy_model.dart';
import 'package:profhunterapp/domain/entities/vacancy.dart';
import 'package:profhunterapp/domain/repositories/vacancy_repository.dart';

class VacancyRepositoryImpl implements VacancyRepository {
  final VacancyRemoteDataSource remoteDataSource;

  VacancyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Vacancy>> getVacancies() async {
    return await remoteDataSource.getVacancies();
  }

  @override
  Future<List<Vacancy>> getVacanciesCompany() async {
    return await remoteDataSource.getVacanciesCompany();
  }

  @override
  Future<Vacancy> getVacancyById({required String idVacancy}) async {
    return await remoteDataSource.getVacancyById(idVacancy: idVacancy);
  }

  @override
  Future<Vacancy> createVacancy({
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required String userID,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
  }) async {
    final data = await remoteDataSource.createVacancy(
      name: name,
      salary: salary,
      companyName: companyName,
      employmentType: employmentType,
      place: place,
      address: address,
      duties: duties,
      requirements: requirements,
      conditions: conditions,
      contacts: contacts,
      userID: userID,
    );

    return VacancyModel.fromJson(data);
  }

  @override
  Future<Vacancy> editVacancy({
    required String id,
    required String name,
    required String salary,
    required String companyName,
    required String employmentType,
    required String place,
    required String address,
    required String userID,
    required List<String> duties,
    required List<String> requirements,
    required List<String> conditions,
    required Map<String, dynamic> contacts,
  }) async {
    final data = await remoteDataSource.editVacancy(
      id: id,
      name: name,
      salary: salary,
      companyName: companyName,
      employmentType: employmentType,
      place: place,
      address: address,
      duties: duties,
      requirements: requirements,
      conditions: conditions,
      contacts: contacts,
      userID: userID,
    );

    return VacancyModel.fromJson(data);
  }

  @override
  Future<void> deleteVacancy({required String id}) async {
    await remoteDataSource.deleteVacancy(id: id);
  }
}
