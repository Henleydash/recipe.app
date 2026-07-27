import '../models/recipe.dart';

/// Source de données fictive.
/// Séparée des widgets pour respecter la règle "aucune donnée hardcodée
/// dans les widgets" : les écrans/widgets ne font que lire cette liste.
class RecipeRepository {
  static final List<Recipe> _recipes = [
    Recipe(
      id: 'r1',
      title: 'Salade César',
      description: 'Une entrée fraîche et croquante avec du poulet grillé.',
      category: RecipeCategory.entree,
      prepTimeMinutes: 15,
      servings: 2,
      ingredients: [
        'Laitue romaine',
        'Blanc de poulet',
        'Parmesan',
        'Croûtons',
        'Sauce César',
      ],
      steps: [
        'Griller le poulet et le couper en lamelles',
        'Laver et couper la laitue',
        'Mélanger tous les ingrédients',
        'Ajouter la sauce et le parmesan râpé',
      ],
      imageEmoji: '🥗',
    ),
    Recipe(
      id: 'r2',
      title: 'Pâtes à la carbonara',
      description: 'Un classique italien crémeux et réconfortant.',
      category: RecipeCategory.plat,
      prepTimeMinutes: 25,
      servings: 4,
      ingredients: [
        'Spaghetti',
        'Lardons',
        'Œufs',
        'Parmesan',
        'Poivre noir',
      ],
      steps: [
        'Cuire les pâtes al dente',
        'Faire revenir les lardons',
        'Mélanger œufs et parmesan',
        'Combiner hors du feu pour éviter que l\'œuf ne cuise trop',
      ],
      imageEmoji: '🍝',
    ),
    Recipe(
      id: 'r3',
      title: 'Poulet au curry',
      description: 'Un plat épicé et parfumé, parfait avec du riz.',
      category: RecipeCategory.plat,
      prepTimeMinutes: 40,
      servings: 4,
      ingredients: [
        'Blanc de poulet',
        'Lait de coco',
        'Pâte de curry',
        'Oignon',
        'Riz basmati',
      ],
      steps: [
        'Faire revenir l\'oignon et le poulet',
        'Ajouter la pâte de curry',
        'Verser le lait de coco et laisser mijoter',
        'Servir avec du riz basmati',
      ],
      imageEmoji: '🍛',
    ),
    Recipe(
      id: 'r4',
      title: 'Tarte au citron meringuée',
      description: 'Un dessert acidulé avec une meringue légère.',
      category: RecipeCategory.dessert,
      prepTimeMinutes: 60,
      servings: 6,
      ingredients: [
        'Pâte sablée',
        'Citrons',
        'Œufs',
        'Sucre',
        'Beurre',
      ],
      steps: [
        'Cuire la pâte à blanc',
        'Préparer la crème au citron',
        'Garnir la pâte refroidie',
        'Ajouter la meringue et dorer au four',
      ],
      imageEmoji: '🍋',
    ),
    Recipe(
      id: 'r5',
      title: 'Brownie au chocolat',
      description: 'Fondant à souhait, un incontournable gourmand.',
      category: RecipeCategory.dessert,
      prepTimeMinutes: 35,
      servings: 8,
      ingredients: [
        'Chocolat noir',
        'Beurre',
        'Sucre',
        'Œufs',
        'Farine',
      ],
      steps: [
        'Faire fondre le chocolat et le beurre',
        'Mélanger avec le sucre et les œufs',
        'Incorporer la farine',
        'Cuire 25 minutes au four',
      ],
      imageEmoji: '🍫',
    ),
    Recipe(
      id: 'r6',
      title: 'Smoothie mangue-passion',
      description: 'Une boisson tropicale rafraîchissante.',
      category: RecipeCategory.boisson,
      prepTimeMinutes: 10,
      servings: 2,
      ingredients: [
        'Mangue',
        'Fruits de la passion',
        'Yaourt nature',
        'Miel',
        'Glaçons',
      ],
      steps: [
        'Éplucher et couper la mangue',
        'Mixer tous les ingrédients',
        'Servir bien frais',
      ],
      imageEmoji: '🥭',
    ),
  ];

  static List<Recipe> getAll() => List.unmodifiable(_recipes);

  static Recipe? getById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  static void add(Recipe recipe) {
    _recipes.add(recipe);
  }

  static void toggleFavorite(String id) {
    final recipe = getById(id);
    if (recipe != null) {
      recipe.isFavorite = !recipe.isFavorite;
    }
  }

  static List<Recipe> getFavorites() =>
      _recipes.where((r) => r.isFavorite).toList();
}
