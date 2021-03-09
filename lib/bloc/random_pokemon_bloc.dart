import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemons/databases/pokemons_database.dart';
import 'package:pokemons/models/pokemon.dart';
import 'package:pokemons/network/network.dart';

part 'random_pokemon_event.dart';
part 'random_pokemon_state.dart';

class RandomPokemonBloc extends Bloc<RandomPokemonEvent, RandomPokemonState> {

  final db = PokemonsDB();

  Pokemon pokemon;

  RandomPokemonBloc() : super(RandomPokemonInitial());

  @override
  Stream<RandomPokemonState> mapEventToState(
    RandomPokemonEvent event,
  ) async* {

    if (event is GetRandomPokemonEvent) {

      yield PokemonIsLoading();

      try {
        
        pokemon = await db.getRandomPokemon();
        // checking one of the key parameters to see if the full data was loaded
        if (pokemon.isDefault != null)  yield PokemonLodaingCompleted(pokemon: pokemon);

        else {

          pokemon = await Network.getPokemonByID(id: pokemon.id);
          await db.updatePokemon(pokemon);

          print('updated');
          yield PokemonLodaingCompleted(pokemon: pokemon);

        }

      } catch (e) {

        yield PokemonLoadError(error: e);

      }
    }

  }
}