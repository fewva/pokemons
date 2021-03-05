import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokemons/models/pokemon.dart';

class Network {

  static Dio get _dio => Dio(
    BaseOptions(
      headers: {"Content-Type": "application/json"},
      baseUrl: 'https://pokeapi.co/api/v2',
      responseType: ResponseType.plain,
    ),
  );

 static Future<List<Pokemon>> getPokemonList() async {

    final ans = await _dio.get('/pokemon/?&limit=2000');
    var a = jsonDecode(ans.data);

    return a['results']
        .map((e) => Pokemon.fromPokemonListItem(e))
        .cast<Pokemon>()
        .toList();

  }

 static Future <Pokemon> getPokemonByID({int id}) async {

    final ans = await _dio.get('/pokemon/$id');
    var a = jsonDecode(ans.data);

    return Pokemon.fromJson(a);

  }

}