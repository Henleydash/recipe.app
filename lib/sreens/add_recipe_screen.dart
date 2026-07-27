import 'package:flutter/material.dart';
import '../data/mock_recipes.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ingredientsController = TextEditingController();

  RecipeCategory _category = RecipeCategory.plat;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepTimeController.dispose();
    _servingsController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        id: 'r${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _category,
        prepTimeMinutes: int.parse(_prepTimeController.text.trim()),
        servings: int.parse(_servingsController.text.trim()),
        ingredients: _ingredientsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        steps: const ['Étape à compléter'],
        imageEmoji: '🍽️',
      );

      RecipeRepository.add(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recette ajoutée avec succès !')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter une recette')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre de la recette',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Le titre est requis';
                  }
                  if (value.trim().length < 3) {
                    return 'Le titre doit contenir au moins 3 caractères';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La description est requise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<RecipeCategory>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(),
                ),
                items: RecipeCategory.values
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat.label),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _prepTimeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Temps (min)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Requis';
                        }
                        final n = int.tryParse(value.trim());
                        if (n == null || n <= 0) {
                          return 'Nombre invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _servingsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Portions',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Requis';
                        }
                        final n = int.tryParse(value.trim());
                        if (n == null || n <= 0) {
                          return 'Nombre invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Ingrédients (séparés par des virgules)',
                  border: OutlineInputBorder(),
                  hintText: 'ex : tomate, oignon, ail',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Au moins un ingrédient est requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('Enregistrer la recette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
