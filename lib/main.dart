import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatefulWidget {
  const RecipeApp({super.key});

  @override
  State<RecipeApp> createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDark) => setState(() => _isDarkMode = isDark);

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => HomeScreen(
          isDarkMode: _isDarkMode,
          onThemeChanged: _toggleTheme,
        ),
      ),
      GoRoute(
        name: 'recette',
        path: '/recette/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RecipeDetailScreen(recipeId: id);
        },
      ),
      GoRoute(
        name: 'ajouter',
        path: '/ajouter',
        builder: (context, state) => const AddRecipeScreen(),
      ),
      GoRoute(
        name: 'favoris',
        path: '/favoris',
        builder: (context, state) => const FavoritesScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recettes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: _router,
    );
  }
}
