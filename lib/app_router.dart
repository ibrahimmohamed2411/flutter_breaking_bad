import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic_layer/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/data/models/character.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:flutter_breaking/data/web_services/characters_web_services.dart';
import 'package:flutter_breaking/presentation_layer/screens/character_details_screen.dart';
import 'package:flutter_breaking/presentation_layer/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit =
        CharactersCubit(charactersRepository: charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final selectedCharacter = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(
              charactersRepository: charactersRepository,
            ),
            child: CharacterDetailsScreen(
              character: selectedCharacter,
            ),
          ),
        );
    }
  }
}
