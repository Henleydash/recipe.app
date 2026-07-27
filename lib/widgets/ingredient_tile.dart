import 'package:flutter/material.dart';

/// Widget réutilisable : une ligne d'ingrédient avec icône.
/// Le texte affiché vient uniquement du paramètre [name], pas de donnée en dur.
class IngredientTile extends StatelessWidget {
  final String name;

  const IngredientTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.check_circle_outline, color: Colors.deepOrange),
      title: Text(name),
    );
  }
}
