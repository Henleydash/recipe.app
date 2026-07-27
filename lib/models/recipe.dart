enum RecipeCategory { entree, plat, dessert, boisson }

extension RecipeCategoryLabel on RecipeCategory {
  String get label {
    switch (this) {
      case RecipeCategory.entree:
        return 'Entrée';
      case RecipeCategory.plat:
        return 'Plat';
      case RecipeCategory.dessert:
        return 'Dessert';
      case RecipeCategory.boisson:
        return 'Boisson';
    }
  }
}

class Recipe {
  final String id;
  final String title;
  final String description;
  final RecipeCategory category;
  final int prepTimeMinutes;
  final int servings;
  final List<String> ingredients;
  final List<String> steps;
  final String imageEmoji; // simple placeholder visuel, pas d'image réseau nécessaire
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.prepTimeMinutes,
    required this.servings,
    required this.ingredients,
    required this.steps,
    required this.imageEmoji,
    this.isFavorite = false,
  });
}
