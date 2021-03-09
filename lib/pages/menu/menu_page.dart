import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/bloc/random_pokemon_bloc.dart';
import 'package:pokemons/components/custom_app_bar.dart';
import 'package:pokemons/components/wide_button.dart';
import 'package:pokemons/pages/random_pokemon/random_pokemon_page.dart';
import 'package:pokemons/pages/search/search_page.dart';


class MenuPage extends StatelessWidget {
  
  const MenuPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Menu'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WideButton(
              text: 'Search',
              color: Colors.black,
              width: 300,
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchPage())
              ),
            ),
            SizedBox(height: 20),
            WideButton(
              text: 'Random',
              width: 300,
              color: Colors.black45,
              onPressed: () async {
                BlocProvider.of<RandomPokemonBloc>(context).add(GetRandomPokemonEvent());
                return Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RandomPokemonPage())
              );
              },
            ),
          ],
        ),
      ),
    );
  }
}