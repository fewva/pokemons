part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {

  final Future <List <Pokemon>> _pokemons = PokemonsDB().getPokemons();  
  Future <List <Pokemon>> get pokemons => _pokemons;

}

class SearchIsLoading extends SearchState {}

class SearchCompleted extends SearchState {

  final List <Pokemon> pokemons;
  SearchCompleted({this.pokemons});

}

class SearchError extends SearchState {

  final error; 
  SearchError({this.error});

}