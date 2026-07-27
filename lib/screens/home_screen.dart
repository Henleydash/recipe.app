import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_recipes.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_filter_bar.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  RecipeCategory? _category;

  List<Recipe> get _filteredRecipes {
    return RecipeRepository.getAll().where((recipe) {
      final matchesQuery =
          recipe.title.toLowerCase().contains(_query.toLowerCase());
      final matchesCategory = _category == null || recipe.category == _category;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _filteredRecipes;
    final width = MediaQuery.of(context).size.width;
    // Responsive : 2 colonnes sur mobile, plus de colonnes sur tablette
    final crossAxisCount = width >= 900 ? 4 : (width >= 600 ? 3 : 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Recettes'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            tooltip: 'Changer le thème',
            onPressed: () => widget.onThemeChanged(!widget.isDarkMode),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Favoris',
            onPressed: () =>
                context.push('/favoris').then((_) => setState(() {})),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SearchFilterBar(
              onSearchChanged: (value) => setState(() => _query = value),
              selectedCategory: _category,
              onCategoryChanged: (cat) => setState(() => _category = cat),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: recipes.isEmpty
                  ? const Center(child: Text('Aucune recette trouvée'))
                  : GridView.builder(
                      itemCount: recipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        final recipe = recipes[index];
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            context.push('/ajouter').then((_) => setState(() {})),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
    );
  }
}
