///
///  CardColumn widget
///
///
///
import 'package:flutter/material.dart';

import 'package:flutter_game/game/solitaire/playing_card.dart';
import 'package:flutter_game/game/solitaire/card_widget.dart';

typedef CardAcceptCallback = void Function(List<PlayingCard>, int);

class CardColumn extends StatefulWidget {

  // List of cards in the stack
  final List<PlayingCard> cards;

  // Callback when card is added to the stack
  final CardAcceptCallback onCardsAdded;

  // The index of the list in the game
  final int columnIndex;

  CardColumn({Key key, this.cards, this.onCardsAdded, this.columnIndex}):super(key: key);

  @override
  State<StatefulWidget> createState() {

    return _CardColumnState();
  }

}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 100.0,
      margin: const EdgeInsets.all(5.0),
      child: DragTarget<Map>(
        builder: (context, listOne, listTwo) {
          return Stack(
            children: widget.cards.map((card) {
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex: index,
                attachedCards: widget.cards.sublist(index, widget.cards.length),
                columnIndex: widget.columnIndex,
              );
            }).toList(),
          );
        },

        onWillAccept: (value) {
          print("onWillAccept +++");
          // If empty, accept
          if (widget.cards.length == 0) {
            print("111111111111111111111");
            return true;
          }

          // Get dragged card list
          List<PlayingCard> draggedCards = value["cards"];
          PlayingCard firstCard = draggedCards.first;
          // red card
          if (firstCard.cardColor == Colors.red) {
            // If the last card is red, Not accept
            if (widget.cards.last.cardColor == Colors.red) {
              print("222222222222222222222222222222222");
              return false;
            }

          } else {
            // If the last card is black, Not accept
            if (widget.cards.last.cardColor == Colors.black) {
              print("3333333333333333333333333333333333");
              return false;
            }

          }

          int lastColumnCardIndex = CardType.values.indexOf(widget.cards.last.cardType);
          int firstDraggedCardIndex = CardType.values.indexOf(firstCard.cardType);
          // Check equal
          if (lastColumnCardIndex != firstDraggedCardIndex + 1) {
            print("4444444444444444444444444444444444444");
            return false;
          }

          return true;
        },

        onAccept: (value) {
          print("onAccept +++");
          widget.onCardsAdded(
            value["cards"],
            value["fromIndex"],
          );
        },

      ),
    );
  }

}