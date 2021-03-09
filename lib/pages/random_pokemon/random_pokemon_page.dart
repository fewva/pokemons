import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/bloc/random_pokemon_bloc.dart';
import 'package:pokemons/components/custom_app_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pokemons/pages/random_pokemon/decorated_characteristic.dart';

class RandomPokemonPage extends StatelessWidget {
  const RandomPokemonPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Random pokemon', showBackArrow: true),
      body: LiquidPullToRefresh(
        animSpeedFactor: 2,
        height: 20,
        color: Colors.black,
        springAnimationDurationInMilliseconds: 300,
        showChildOpacityTransition: false,
        onRefresh: () async {
          BlocProvider.of<RandomPokemonBloc>(context).add(GetRandomPokemonEvent());
        },
        child: BlocBuilder<RandomPokemonBloc, RandomPokemonState>(
          builder: (context, state) {
            print('state is: ' + state.toString());
            if (state is PokemonIsLoading)
              return const Center(child: CircularProgressIndicator());
              
            if (state is PokemonLodaingCompleted) {
              var _pokemon = state.pokemon;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
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
              );
            }

            if (state is PokemonLoadError)
              return Center(child: Text(state.error.toString()));

            return const Text("idk what's wrong");
          },
        ),
      ),
    );
  }
}