import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pokemons/databases/pokemons_database.dart';
import 'package:pokemons/models/pokemon.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchState> {

  final List <Pokemon> pokemons;
  SearchBloc({this.pokemons}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchBlocEvent event,
  ) async* {

    if (event is SearchEvent) {

      yield SearchIsLoading(); 
      
      try{
        
        List <Pokemon> filteredPokemons = pokemons.where((element) => element.name.contains(event.eventData)).toList();
        yield SearchCompleted(pokemons: filteredPokemons); 

      } catch (e) {
        
        debugPrint(e);
        yield SearchError(error: e);

      }
    }
  }
}
