// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SpoonacularService extends SpoonacularService {
  _$SpoonacularService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SpoonacularService;

  @override
  Future<Response<Result<Recipe>>> queryRecipe(String id) {
    final Uri $url =
        Uri.parse('recipes/${id}/information?includeNutrition=false');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Result<Recipe>, Recipe>($request);
  }

  @override
  Future<Response<Result<QueryResult>>> queryRecipes(
    String query,
    int offset,
    int number,
  ) {
    final Uri $url = Uri.parse('recipes/complexSearch');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'offset': offset,
      'number': number,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Result<QueryResult>, QueryResult>($request);
  }
}
