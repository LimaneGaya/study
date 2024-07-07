import 'package:chopper/chopper.dart';
import 'model_response.dart';
import 'query_result.dart';
import 'service_interface.dart';
import '../data/models/models.dart';
import 'spoonacular_converter.dart';
part 'spoonacular_service.chopper.dart';

const String apiKey = 'a2496463e1ec4b07a1ad00bb7fa5d64a';
const String apiUrl = 'https://api.spoonacular.com/';

@ChopperApi()
abstract class SpoonacularService extends ChopperService
    implements ServiceInterface {
  @override
  @Get(path: 'recipes/{id}/information?includeNutrition=false')
  Future<RecipeDetailsResponse> queryRecipe(
    @Path('id') String id,
  );
  @override
  @Get(path: 'recipes/complexSearch')
  Future<RecipeResponse> queryRecipes(
    @Query('query') String query,
    @Query('offset') int offset,
    @Query('number') int number,
  );
  static SpoonacularService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: SpoonacularConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$SpoonacularService(),
      ],
    );
    return _$SpoonacularService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['apiKey'] = apiKey;
  return req.copyWith(parameters: params);
}
