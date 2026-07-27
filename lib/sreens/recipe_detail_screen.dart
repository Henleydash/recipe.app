import 'package:flutter/material.dart';
import '../data/mock_recipes.dart';
import '../models/recipe.dart';
import '../widgets/ingredient_tile.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final recipe = RecipeRepository.getById(widget.recipeId);

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recette introuvable')),
        body: const Center(child: Text('Cette recette n\'existe pas.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            icon: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? Colors.redAccent : null,
            ),
            onPressed: () => setState(
              () => RecipeRepository.toggleFavorite(recipe.id),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(recipe.imageEmoji, style: const TextStyle(fontSize: 72)),
          ),
          const SizedBox(height: 12),
          Text(recipe.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text(recipe.category.label)),
              Chip(
                avatar: const Icon(Icons.timer_outlined, size: 18),
                label: Text('${recipe.prepTimeMinutes} min'),
              ),
              Chip(
                avatar: const Icon(Icons.people_outline, size: 18),
                label: Text('${recipe.servings} portions'),
              ),
            ],
          ),
          const Divider(height: 32),
          Text('Ingrédients', style: Theme.of(context).textTheme.titleLarge),
          ...recipe.ingredients.map((i) => IngredientTile(name: i)),
          const Divider(height: 32),
          Text('Préparation', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...recipe.steps.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        child: Text('${entry.key + 1}'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(entry.value)),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
