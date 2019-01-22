///
/// Card widget
///
import 'package:flutter/material.dart';

import 'package:flutter_game/game/solitaire/playing_card.dart';
import 'package:flutter_game/game/solitaire/card_column.dart';

class TransformedCard extends StatefulWidget {

  // The card model to display
  final PlayingCard playingCard;

  // The distance to translate the card in the Y axis (default: 15.0)
  final double transformDistance;

  // The index of the card in the card column
  final int transformIndex;

  // The index of the column in the seven card columns in the game
  final int columnIndex;

  // Cards below the current card in the card column
  final List<PlayingCard> attachedCards;

  TransformedCard({
    Key key,
    this.playingCard,
    this.transformDistance = 15.0,
    this.attachedCards,
    this.transformIndex = 0,
    this.columnIndex}):super(key: key);

  @override
  State<StatefulWidget> createState() {

    return _TransformedCardState();
  }

}

class _TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {

    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, widget.transformIndex*widget.transformDistance, 0.0,),
      child: (widget.playingCard.faceUp == true)? _buildFaceUpCard(): _buildFaceDownCard(),
    );
  }

  Widget _buildFaceDownCard() {
    return Container(
      height: 60.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildFaceUpCard() {
    return Draggable<Map>(
      child: _buildCardView(),
      feedback: CardColumn(
        cards: widget.attachedCards,
        columnIndex: 1,
        onCardsAdded: (cards, position) {},
      ),
      childWhenDragging: _buildCardView(),
      data: {
        "cards": widget.attachedCards,
        "fromIndex": widget.columnIndex,
      },
    );
  }

  Widget _buildCardView() {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              Center(
                child: Text(widget.playingCard.suitToString, style: TextStyle(fontSize: 16.0, color: widget.playingCard.cardColor),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(widget.playingCard.typeToString, style: TextStyle(fontSize: 12.0),),
                ),
              ),
            ],
          ),
        ),
        height: 60.0,
        width: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );

  }


}