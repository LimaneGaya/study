// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      summary: json['summary'] as String?,
      bookmarked: json['bookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'summary': instance.summary,
      'bookmarked': instance.bookmarked,
    };
