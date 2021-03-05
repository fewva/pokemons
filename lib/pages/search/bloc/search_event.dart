part of 'search_bloc.dart';

@immutable
abstract class SearchBlocEvent {

  final String eventData;
  SearchBlocEvent({this.eventData});

}

class SearchEvent extends SearchBlocEvent {

  final String eventData;
  SearchEvent({this.eventData});

}
