import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/components/custom_app_bar.dart';
import 'package:pokemons/databases/pokemons_database.dart';
import 'package:pokemons/pages/search/bloc/search_bloc.dart';
import 'package:pokemons/theme.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search', showBackArrow: true),
      body: FutureBuilder(
        future: PokemonsDB().getPokemons(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return BlocProvider(
              create: (context) => SearchBloc(pokemons: snapshot.data),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    Search(),
                    SizedBox(height: 16),
                    PokemonList()
                  ],
                ),
              )
            );

          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()),);

          else return const Text('SMTH WENT WRONG');
        },
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: font),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 1)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
        contentPadding: EdgeInsets.only(left: 13),
        hintStyle: TextStyle(height: 1.5, fontSize: 16, fontWeight: FontWeight.w500)
      ),
      onChanged: (value) {
        BlocProvider.of<SearchBloc>(context).add(SearchEvent(eventData: value));
      },
    );
  }
}

class PokemonList extends StatelessWidget {
  const PokemonList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        debugPrint('STATE IS: ' + state.toString());
        if (state is SearchInitial) {
          return  Expanded(
            child: ListView.separated(
              itemCount: BlocProvider.of<SearchBloc>(context).pokemons.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  child: Text(
                    BlocProvider.of<SearchBloc>(context).pokemons[index].name,
                    style: _listItemTextStyle
                  ),
                );
              },
            ),
          );
        }
        if (state is SearchCompleted) {
          return  Expanded(
            child: ListView.separated(
              itemCount: state.pokemons.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  child: Text(
                    state.pokemons[index].name,
                    style: _listItemTextStyle,
                  ),
                );
              },
            ),
          );
        }

        if (state is SearchError)
          return const Center(child: Text('ERROR BloC'));

        else return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

TextStyle _listItemTextStyle = TextStyle(
  fontFamily: font,
  fontSize: 16,
  fontWeight: FontWeight.w400
);