import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_recipes.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = RecipeRepository.getFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Favoris')),
      body: favorites.isEmpty
          ? const Center(child: Text('Aucune recette favorite pour le moment'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];
                return RecipeCard(
                  recipe: recipe,
                  onTap: () => context
                      .push('/recette/${recipe.id}')
                      .then((_) => setState(() {})),
                  onFavoriteToggle: () => setState(
                    () => RecipeRepository.toggleFavorite(recipe.id),
                  ),
                );
              },
            ),
    );
  }
}
