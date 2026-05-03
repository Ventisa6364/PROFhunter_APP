import 'package:profhunterapp/domain/entities/vacancy.dart';

abstract class VacancyRepository {
  Future<List<Vacancy>> getVacancies();
}