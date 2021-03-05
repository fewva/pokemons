import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokemons/components/custom_app_bar.dart';
import 'package:pokemons/databases/pokemons_database.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pokemons/models/pokemon.dart';
import 'package:pokemons/network/network.dart';
import 'package:pokemons/pages/random_pokemon/decorated_characteristic.dart';


class RandomPokemonPage extends StatefulWidget {
  RandomPokemonPage({Key key}) : super(key: key);

  @override
  _RandomPokemonPageState createState() => _RandomPokemonPageState();
}

class _RandomPokemonPageState extends State<RandomPokemonPage> {

  final StreamController _streamController = StreamController();

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }


  @override
  Widget build(BuildContext context) {

    _streamController.addStream(getPokemon().asStream());

    return Scaffold(
      appBar: CustomAppBar(title: 'Random pokemon', showBackArrow: true),
      body: StreamBuilder(
        // future: getPokemon(),
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          if (!snapshot.hasData)
            return const Center(child: const CircularProgressIndicator());
          else {
            
            Pokemon _pokemon = snapshot.data;

            return LiquidPullToRefresh(
              onRefresh: () async {
                try {
                  var _newPokemon = await getPokemon();
                  _streamController.add(_newPokemon); 
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar(e));
                }
              },
              animSpeedFactor: 2,
              height: 20,
              color: Colors.black,
              springAnimationDurationInMilliseconds: 300,
              showChildOpacityTransition: false,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DecoratedCharacteristic(
                      name: 'id',
                      info:_pokemon.id.toString()
                    ),
                    DecoratedCharacteristic(
                      name: 'name',
                      info:_pokemon.name.toString()
                    ),
                    DecoratedCharacteristic(
                      name: 'is default',
                      info:_pokemon.isDefault.toString()
                    ),
                    DecoratedCharacteristic(
                      name: 'height',
                      info:_pokemon.height.toString()
                    ),
                    DecoratedCharacteristic(
                      name: 'height',
                      info:_pokemon.weight.toString()
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}


Future <Pokemon> getPokemon() async {

  var db = PokemonsDB();

  Pokemon pokemon;

  pokemon = await db.getRandomPokemon();

  // checking one of the key parameters to see if the full data was loaded
  if (pokemon.isDefault != null)  return pokemon;

  else {

    pokemon = await Network.getPokemonByID(id: pokemon.id);
    await db.updatePokemon(pokemon);

    print('updated');
    return pokemon;

  }

}

SnackBar _snackBar(error) {
  return SnackBar(
    backgroundColor: Colors.white,
    elevation: 10,
    content: Text(error.toString(), style: TextStyle(color: Colors.black)),
    action: SnackBarAction(
      label: 'ok',
      textColor: Colors.redAccent,
      onPressed: () {
        print('Error');
      },
    ),
  );
} 