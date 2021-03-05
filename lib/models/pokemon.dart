

import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()

class Pokemon {

  final int baseExperience;
  final int height;
  final int id;
  final bool isDefault;
  final String name;
  final int weight;

  Pokemon({
    this.baseExperience,
    this.height,
    this.id,
    this.isDefault,
    this.name,
    this.weight
  });

  factory Pokemon.fromJson(json) => _$PokemonFromJson(json);
  Map<String,dynamic> toJson() => _$PokemonToJson(this);

  factory Pokemon.fromDB(json) => _$PokemonFromDB(json);
  Map<String,dynamic> toDBjson() => _$PokemonToDBjson(this);

  factory Pokemon.fromPokemonListItem(item) {

    int id = int.parse(item['url'].substring(34, item['url'].length - 1));

    return Pokemon(id: id, name: item['name']);

  }

}