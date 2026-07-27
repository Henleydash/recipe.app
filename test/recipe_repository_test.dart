import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/data/mock_recipes.dart';
import 'package:recipe_app/models/recipe.dart';

void main() {
  group('RecipeRepository', () {
    test('getAll retourne une liste non vide de recettes', () {
      final recipes = RecipeRepository.getAll();
      expect(recipes, isNotEmpty);
    });

    test('getById retourne la bonne recette pour un id valide', () {
      final all = RecipeRepository.getAll();
      final first = all.first;
      final found = RecipeRepository.getById(first.id);
      expect(found, isNotNull);
      expect(found!.title, first.title);
    });

    test('getById retourne null pour un id inexistant', () {
      final found = RecipeRepository.getById('id_qui_nexiste_pas');
      expect(found, isNull);
    });

    test('add ajoute bien une nouvelle recette à la liste', () {
      final initialCount = RecipeRepository.getAll().length;
      final newRecipe = Recipe(
        id: 'test_id_1',
        title: 'Recette de test',
        description: 'Description de test',
        category: RecipeCategory.plat,
        prepTimeMinutes: 20,
        servings: 2,
        ingredients: ['ingredient 1'],
        steps: ['étape 1'],
        imageEmoji: '🍽️',
      );
      RecipeRepository.add(newRecipe);
      expect(RecipeRepository.getAll().length, initialCount + 1);
      expect(RecipeRepository.getById('test_id_1'), isNotNull);
    });

    test('toggleFavorite bascule correctement le statut favori', () {
      final recipe = RecipeRepository.getAll().first;
      final initialStatus = recipe.isFavorite;
      RecipeRepository.toggleFavorite(recipe.id);
      expect(RecipeRepository.getById(recipe.id)!.isFavorite, !initialStatus);
      // on remet dans l'état initial pour ne pas affecter les autres tests
      RecipeRepository.toggleFavorite(recipe.id);
    });

    test('getFavorites ne retourne que les recettes marquées favorites', () {
      final recipe = RecipeRepository.getAll().first;
      RecipeRepository.toggleFavorite(recipe.id);
      final favorites = RecipeRepository.getFavorites();
      expect(favorites.every((r) => r.isFavorite), isTrue);
      expect(favorites.any((r) => r.id == recipe.id), isTrue);
      RecipeRepository.toggleFavorite(recipe.id);
    });
  });

  group('RecipeCategory', () {
    test('label retourne le bon texte français pour chaque catégorie', () {
      expect(RecipeCategory.entree.label, 'Entrée');
      expect(RecipeCategory.plat.label, 'Plat');
      expect(RecipeCategory.dessert.label, 'Dessert');
      expect(RecipeCategory.boisson.label, 'Boisson');
    });
  });
}
