import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic_layer/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/character.dart';
import 'dart:math';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('job : ', character.occupation.join(' - ')),
                      buildDivider(350),
                      // characterInfo('appeared in : ', character.join(' - ')),
                      // buildDivider(250),
                      characterInfo(
                          'seasons : ', character.appearance.join(' - ')),
                      buildDivider(250),
                      characterInfo('status : ', character.status),
                      buildDivider(250),
                      characterInfo('betterCallSaulAppearance  : ',
                          character.betterCallSaulAppearance.join(' - ')),
                      buildDivider(250),
                      characterInfo('actor  : ', character.actorName),
                      buildDivider(250),
                      SizedBox(
                        height: 100,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget displayRandomQuoteOrEmptySpace(QuotesLoaded state) {
    var quotes = state.quotes;
    if (quotes.isNotEmpty) {
      int randomQuoteIndex = Random().nextInt(quotes.length);
      return Center(
        child: DefaultTextStyle(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
          style: TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
            Shadow(
                blurRadius: 7, color: MyColors.myYellow, offset: Offset(0, 0))
          ]),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickname,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
