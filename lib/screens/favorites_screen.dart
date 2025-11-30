import 'package:flutter/material.dart';
import '../models/favorite_manager.dart';
import '../widgets/meal_grid_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteManager.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Recipes"),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "You don't have favorite recipes.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.78,
        children: [
          for (final meal in favorites) MealGridItem(meal: meal),
        ],
      ),
    );
  }
}
