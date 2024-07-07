import 'package:freezed_annotation/freezed_annotation.dart';

import 'ingredient.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    int? id,
    String? title,
    String? image,
    String? summary,
    @Default(false) bool bookmarked,
    //@Default(<Ingredient>[]) List<Ingredient> ingredients
  }) = _Recipe;

  // Create a Recipe from JSON data
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

}
