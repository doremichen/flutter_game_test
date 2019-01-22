///
/// Just use dto practice
///
import 'package:flutter/material.dart';

import 'package:flutter_game/game/solitaire/playing_card.dart';
import 'package:flutter_game/game/solitaire/card_widget.dart';

typedef CardAcceptCallback = void Function(List<PlayingCard>, int);

class SuitCardDeck extends StatefulWidget {

  final CardSuit cardSuit;
  final List<PlayingCard> cardsAdded;
  final CardAcceptCallback onCardAdded;
  final int columnIndex;

  SuitCardDeck({
    Key key,
    @required this.cardSuit,
    @required this.cardsAdded,
    @required this.onCardAdded,
    this.columnIndex}): super(key: key);

  @override
  State<StatefulWidget> createState() {

    return _SuitCardDeckState();
  }

}

class _SuitCardDeckState extends State<SuitCardDeck> {
  @override
  Widget build(BuildContext context) {

    return DragTarget<Map>(
        builder: (context, listOne, listTwo) {
          return widget.cardsAdded.isEmpty?
              Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  height: 60.0,
                  width: 40.0,
                  // card display
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 20.0,
                            child: Text(_suitToString(), style: TextStyle(fontSize: 12.0),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ):
              TransformedCard(
                playingCard: widget.cardsAdded.last,
                columnIndex: widget.columnIndex,
                attachedCards: [widget.cardsAdded.last,],
              );
        },
        onWillAccept: (value) {
          print("onWillAccept@SuitCardDeck");
          PlayingCard cardAdded = value["cards"].last;
          // check card suit
          if (cardAdded.cardSuit == widget.cardSuit) {
            if (widget.cardsAdded.length == CardType.values.indexOf(cardAdded.cardType)) {
              return true;
            }
          }


          return false;
        },
      onAccept: (value) {
        print("onAccept@SuitCardDeck");
          widget.onCardAdded(
            value["cards"],
            value["fromIndex"],
          );
      },
    );
  }

  //
  // private subroutine section
  //
  String _suitToString() {
    switch (widget.cardSuit) {
      case CardSuit.diamonds:
        return "D";
      case CardSuit.hearts:
        return "H";
      case CardSuit.spades:
        return "S";
      case CardSuit.clubs:
        return "C";
    }
    return "";
  }
}

