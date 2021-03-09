part of 'random_pokemon_bloc.dart';

@immutable
abstract class RandomPokemonState {}

class RandomPokemonInitial extends RandomPokemonState {}

class PokemonIsLoading extends RandomPokemonState {}

class PokemonLodaingCompleted extends RandomPokemonState {

  final Pokemon pokemon;
  PokemonLodaingCompleted({this.pokemon});

}

class PokemonLoadError extends RandomPokemonState {

  final error; 
  PokemonLoadError({this.error});

}
