// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    baseExperience: json['base_experience'] as int,
    height: json['height'] as int,
    id: json['id'] as int,
    isDefault: json['is_default'] as bool,
    name: json['name'] as String,
    weight: json['weight'] as int,
  );
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'base_experience': instance.baseExperience,
      'height': instance.height,
      'id': instance.id,
      'is_default': instance.isDefault,
      'name': instance.name,
      'weight': instance.weight,
    };


Pokemon _$PokemonFromDB(Map<String, dynamic> json) {
  
  // json may be read-only :(
  Map newJson = Map.from(json);

  if (newJson['is_default'] != null)
      newJson['is_default'] = newJson['is_default'] == 1 ? true : false;

  return Pokemon(
    baseExperience: newJson['base_experience'] as int,
    height: newJson['height'] as int,
    id: newJson['id'] as int,
    isDefault: newJson['is_default'],
    name: newJson['name'] as String,
    weight: newJson['weight'] as int,
  );
}

Map<String, dynamic> _$PokemonToDBjson(Pokemon instance) => <String, dynamic>{
      'base_experience': instance.baseExperience,
      'height': instance.height,
      'id': instance.id,
      if (instance.isDefault != null)
          'is_default': instance.isDefault ? 1 : 0,
      'name': instance.name,
      'weight': instance.weight,
    };