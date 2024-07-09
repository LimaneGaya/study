import 'package:recipes/data/repositories/db_repository.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipes/data/database/recipe_db.dart';
import 'package:recipes/data/models/ingredient.dart';

@GenerateNiceMocks([
MockSpec<RecipeDatabase>(),
MockSpec<RecipeDao>(),
MockSpec<IngredientDao>(),
])

void main() {
  group('DBRepository', () {
    test('can instantiate', () {
// Arrange
      late DBRepository dbRepository;
// Act
      dbRepository = DBRepository();
// Assert
      expect(dbRepository, isNotNull);
      expect(dbRepository.recipeDatabase, isNotNull);
    });
  });
}
