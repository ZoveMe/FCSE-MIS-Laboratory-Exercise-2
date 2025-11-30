import '../models/meal_summary.dart';

class FavoriteManager {
  static final List<MealSummary> _favorites = [];

  static List<MealSummary> get favorites => _favorites;

  static bool isFavorite(MealSummary meal) {
    return _favorites.any((m) => m.idMeal == meal.idMeal);
  }

  static void toggleFavorite(MealSummary meal) {
    if (isFavorite(meal)) {
      _favorites.removeWhere((m) => m.idMeal == meal.idMeal);
    } else {
      _favorites.add(meal);
    }
  }
}
