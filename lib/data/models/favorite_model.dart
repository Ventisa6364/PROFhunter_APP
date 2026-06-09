import 'package:profhunterapp/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  FavoriteModel({
    required super.id,
    required super.user,
    required super.vacancy,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? '',
      user: map['user'] ?? '',
      vacancy: map['vacancy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'vacancy': vacancy,
    };
  }
}
