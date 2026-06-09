import 'package:profhunterapp/data/models/vacancy_model.dart';
import 'package:profhunterapp/domain/entities/favorite.dart';

class FavoriteViewData {
  final Favorite favorite;
  final VacancyModel vacancy;

  FavoriteViewData({
    required this.favorite,
    required this.vacancy,
  });
}