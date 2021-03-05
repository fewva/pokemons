import 'package:flutter/material.dart';
import 'package:pokemons/databases/pokemons_database.dart';
import 'package:pokemons/models/pokemon.dart';
import 'package:pokemons/network/network.dart';
import 'package:pokemons/pages/menu/menu_page.dart';
import 'package:pokemons/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: FutureBuilder(
        future: _getAndSavePokemons(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return MenuPage();
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else return const Material(child: Center(child: Text('waiting')));
        }
      ),
    );
  }
}

Future <bool> _getAndSavePokemons() async {

  List <Pokemon> l = await Network.getPokemonList();
  await PokemonsDB().insertPokemons(l);
  return true;

}