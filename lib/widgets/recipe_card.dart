import 'package:flutter/material.dart';
import '../models/recipe.dart';

/// Widget réutilisable : carte affichant un aperçu de recette.
/// Ne contient aucune donnée en dur : tout vient du [Recipe] passé en paramètre.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(recipe.imageEmoji, style: const TextStyle(fontSize: 32)),
                  const Spacer(),
                  if (onFavoriteToggle != null)
                    IconButton(
                      icon: Icon(
                        recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: recipe.isFavorite ? Colors.redAccent : null,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                ],
              ),
              Text(
                recipe.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                recipe.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(recipe.category.label),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.timer_outlined, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 2),
                  Text('${recipe.prepTimeMinutes} min'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
