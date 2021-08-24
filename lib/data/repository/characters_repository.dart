import 'package:flutter/foundation.dart';
import 'package:flutter_breaking/data/models/character.dart';
import 'package:flutter_breaking/data/models/quote.dart';
import 'package:flutter_breaking/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  const CharactersRepository({required this.charactersWebServices});
  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return compute(parseCharacters, characters);
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebServices.getCharacterQuotes(charName);
    return compute(parseQuotes, quotes);
  }
}

List<Character> parseCharacters(List<dynamic> characters) {
  return characters.map((character) => Character.fromJson(character)).toList();
}

List<Quote> parseQuotes(List<dynamic> quotes) {
  return quotes.map((quote) => Quote.fromJson(quote)).toList();
}
