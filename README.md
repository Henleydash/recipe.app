# 🍽️ Recipe App — Projet de certification Flutter

Application Flutter multi-écrans sur le thème des **recettes de cuisine**, développée pour valider la maîtrise des widgets Flutter et de la navigation.

## Fonctionnalités

- **Écran d'accueil** : grille de recettes responsive avec recherche en temps réel et filtrage par catégorie (Entrée, Plat, Dessert, Boisson)
- **Écran de détail** : affichage complet d'une recette (ingrédients, étapes, temps de préparation, portions) via passage de paramètre dans la route
- **Formulaire d'ajout** : création d'une nouvelle recette avec validation sur 5 champs (titre, description, temps, portions, ingrédients)
- **Écran des favoris** : liste des recettes marquées comme favorites
- **Thème clair / sombre** : basculable depuis l'écran d'accueil

## Navigation

Navigation gérée avec **go_router** et routes nommées :

| Route | Écran |
|---|---|
| `/` | Accueil |
| `/recette/:id` | Détail d'une recette |
| `/ajouter` | Formulaire d'ajout |
| `/favoris` | Favoris |

## Architecture

```
lib/
├── models/
│   └── recipe.dart          # Modèle de données Recipe + enum RecipeCategory
├── data/
│   └── mock_recipes.dart    # Source de données fictives (séparée de l'UI)
├── theme/
│   └── app_theme.dart       # Thèmes clair/sombre
├── widgets/                 # Widgets réutilisables
│   ├── recipe_card.dart
│   ├── search_filter_bar.dart
│   └── ingredient_tile.dart
├── screens/
│   ├── home_screen.dart
│   ├── recipe_detail_screen.dart
│   ├── add_recipe_screen.dart
│   └── favorites_screen.dart
└── main.dart                 # Point d'entrée + configuration GoRouter
```

## Widgets utilisés (8+)

GridView, ListView, Stack (via Card/InkWell), Card, TextFormField, DropdownButtonFormField, Chip/ChoiceChip, CircleAvatar, IconButton, FloatingActionButton.

## Gestion d'état

`StatefulWidget` + `setState` uniquement — pas de package de state management externe, pour un code simple et lisible.

## Séparation UI / données

Aucune donnée n'est écrite en dur dans les widgets : toutes les recettes viennent de `RecipeRepository` (`lib/data/mock_recipes.dart`), consulté par les écrans.

## Tests

7 tests unitaires dans `test/recipe_repository_test.dart` couvrant le repository (ajout, recherche par id, favoris) et le modèle (`RecipeCategory.label`).

## Instructions de lancement

1. Installer les dépendances :
   ```
   flutter pub get
   ```
2. Lancer l'application :
   ```
   flutter run
   ```
3. Lancer les tests :
   ```
   flutter test
   ```

## Difficultés rencontrées / notes pour le reviewer

- Choix de `go_router` pour bénéficier de routes nommées et d'un passage de paramètre propre (`/recette/:id`) plutôt que Navigator 1.0.
- Gestion d'état volontairement simple (`setState`) : le repository est statique en mémoire, donc les écrans se resynchronisent via `.then((_) => setState(() {}))` après chaque navigation qui peut modifier les données (favoris, ajout).
- Le responsive est géré via `MediaQuery` pour adapter le nombre de colonnes de la grille (2 sur mobile, 3 sur tablette, 4 sur grand écran).
