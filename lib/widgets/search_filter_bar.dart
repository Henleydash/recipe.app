import 'package:flutter/material.dart';
import '../models/recipe.dart';

/// Widget réutilisable : champ de recherche + filtre par catégorie.
/// Toutes les valeurs (texte, catégorie sélectionnée) sont contrôlées
/// par le parent via les paramètres, aucune donnée en dur ici.
class SearchFilterBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final RecipeCategory? selectedCategory;
  final ValueChanged<RecipeCategory?> onCategoryChanged;

  const SearchFilterBar({
    super.key,
    required this.onSearchChanged,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Rechercher une recette...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ChoiceChip(
                label: const Text('Toutes'),
                selected: selectedCategory == null,
                onSelected: (_) => onCategoryChanged(null),
              ),
              const SizedBox(width: 8),
              ...RecipeCategory.values.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat.label),
                    selected: selectedCategory == cat,
                    onSelected: (_) => onCategoryChanged(cat),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
