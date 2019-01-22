///
/// Just used to practice
///
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_game/game/solitaire/playing_card.dart';
import 'package:flutter_game/game/solitaire/card_widget.dart';
import 'package:flutter_game/game/solitaire/card_column.dart';
import 'package:flutter_game/game/solitaire/suit_card.dart';

class Solitaire extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _SolitaireState();
  }

}

class _SolitaireState extends State<Solitaire> {

  // Seven columns
  List<PlayingCard> cardColumn1 = [];
  List<PlayingCard> cardColumn2 = [];
  List<PlayingCard> cardColumn3 = [];
  List<PlayingCard> cardColumn4 = [];
  List<PlayingCard> cardColumn5 = [];
  List<PlayingCard> cardColumn6 = [];
  List<PlayingCard> cardColumn7 = [];

  // Total of column
  static final int totalCardsInColumn = 28;

  // Remaining card deck
  List<PlayingCard> cardDeckOpened = [];
  List<PlayingCard> cardDeckClosed = [];

  // final suit card deck
  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  // Column boundary list since seven column and
  // column 1 has 1 card, column 2 has 2 cards and so on
  List<int> columnBoundaryList = [0, 2, 5, 9, 14, 20, 27];

  // Map index and column list
  Map cardColumnMap = new Map<int, List<PlayingCard>>();



  List<PlayingCard> allCards = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text("Welcome to solitaire game"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Remaining card deck
              _buildRemainingCardDeck(),
              // Suit deck
              _buildSuitCardDeck(),
            ],
          ),
          Container(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Card column
              Expanded(
                child: CardColumn(
                  cards: cardColumn1,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn1);
                  },
                  columnIndex: 1,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn2,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn2);
                  },
                  columnIndex: 2,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn3,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn3);
                  },
                  columnIndex: 3,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn4,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn4);
                  },
                  columnIndex: 4,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn5,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn5);
                  },
                  columnIndex: 5,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn6,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn6);
                  },
                  columnIndex: 6,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumn7,
                  onCardsAdded: (cards, index) {
                    _addCardCallBack(cards, index, cardColumn7);
                  },
                  columnIndex: 7,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // initial 52 cards
    _initialCards();

  }

  void _initialCards() {

    // initial 52 cards
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(PlayingCard(
            cardSuit: suit,
            cardType: type,
            faceUp: false,
            opened: false,
        ));
      });
    });

    _buildCardColumn();
  }

  //
  // private subRoutine section
  //
  Widget _buildRemainingCardDeck() {
    return Container(
      child: Row(
        children: <Widget>[
          //Card close state
          InkWell(
            child: cardDeckClosed.isEmpty?
            Opacity(
              opacity: 0.4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TransformedCard(
                  playingCard: PlayingCard(
                      cardSuit: CardSuit.diamonds,
                      cardType: CardType.five,
                  ),
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(4.0),
              child: TransformedCard(
                playingCard: cardDeckClosed.last,
              ),

            ),
            onTap: () {
              print("Hit close card");
              // Update UI
              setState(() {
                if (cardDeckClosed.isEmpty) {
                  print("cardDeckClosed is empty");
                  cardDeckClosed.addAll(cardDeckOpened.map((card) {
                    return card
                        ..opened = true
                        ..faceUp = true;
                  }));
                  cardDeckOpened.clear();
                } else {
                  print("cardDeckClosed is not empty");
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                        ..opened = true
                        ..faceUp = true,
                  );
                }
              });
            },
          ),

          // Card open state
          cardDeckOpened.isEmpty?
              Container(
                 width: 50.0,
              )
              : Padding(
                padding: const EdgeInsets.all(4.0),
                child: TransformedCard(
                  playingCard: cardDeckOpened.last,
                  attachedCards: [cardDeckOpened.last,],
                  columnIndex: 0,
                ),
          ),

        ],
      ),
    );
  }

  Widget _buildSuitCardDeck() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SuitCardDeck(
                cardSuit: CardSuit.hearts,
                cardsAdded: finalHeartsDeck,
                onCardAdded: (cards, index) {
                  _addCardCallBack(cards, index, finalHeartsDeck);
                },
                columnIndex: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SuitCardDeck(
              cardSuit: CardSuit.clubs,
              cardsAdded: finalClubsDeck,
              onCardAdded: (cards, index) {
                _addCardCallBack(cards, index, finalClubsDeck);
              },
              columnIndex: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SuitCardDeck(
              cardSuit: CardSuit.spades,
              cardsAdded: finalSpadesDeck,
              onCardAdded: (cards, index) {
                _addCardCallBack(cards, index, finalSpadesDeck);
              },
              columnIndex: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SuitCardDeck(
              cardSuit: CardSuit.diamonds,
              cardsAdded: finalDiamondsDeck,
              onCardAdded: (cards, index) {
                _addCardCallBack(cards, index, finalDiamondsDeck);
              },
              columnIndex: 11,
            ),
          ),
        ],
      ),
    );
  }

  _buildCardColumn() {
    Random random = Random();
    // Add cards to column and remaining to deck
    for (int i = 0; i < totalCardsInColumn; i++) {
      int cardNumber = random.nextInt(allCards.length);
      if (i == 0) {
        _addCardToColumn(cardColumn1, cardNumber, i);
      } else if (i > 0 && i < 3) {
        _addCardToColumn(cardColumn2, cardNumber, i);
      } else if (i > 2 && i < 6) {
        _addCardToColumn(cardColumn3, cardNumber, i);
      } else if (i > 5 && i < 10) {
        _addCardToColumn(cardColumn4, cardNumber, i);
      } else if (i > 9 && i < 15) {
        _addCardToColumn(cardColumn5, cardNumber, i);
      } else if (i > 14 && i < 21) {
        _addCardToColumn(cardColumn6, cardNumber, i);
      } else {
        _addCardToColumn(cardColumn7, cardNumber, i);
      }
    }

    // build column map
    cardColumnMap[0] = cardDeckOpened;
    cardColumnMap[1] = cardColumn1;
    cardColumnMap[2] = cardColumn2;
    cardColumnMap[3] = cardColumn3;
    cardColumnMap[4] = cardColumn4;
    cardColumnMap[5] = cardColumn5;
    cardColumnMap[6] = cardColumn6;
    cardColumnMap[7] = cardColumn7;
    cardColumnMap[8] = finalHeartsDeck;
    cardColumnMap[9] = finalClubsDeck;
    cardColumnMap[10] = finalSpadesDeck;
    cardColumnMap[11] = finalDiamondsDeck;


    _addRemianingCards();

  }

  _addCardToColumn(List<PlayingCard> column, int randomCard, int index) {
    
    // Boundary check
    if (columnBoundaryList.contains(index)) {
      PlayingCard card = allCards[randomCard];
      column.add(card
                ..opened = true
                ..faceUp = true,);
    } else {
      column.add(allCards[randomCard]);
    }
    // remove data in allCards
    allCards.removeAt(randomCard);
  }

  _addRemianingCards() {
    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
          ..opened = true
          ..faceUp = true
    );

    //Update UI
    setState(() {

    });
  }

  _addCardCallBack(List<PlayingCard> cards, int index, List<PlayingCard> currCol) {
      print("+++ _addCardCallBack +++");
      setState(() {
          currCol.addAll(cards);
          // get the length of the from column
          List<PlayingCard> fromColumn = cardColumnMap[index];
          int length = fromColumn.length;
          if (length != 0) {
            fromColumn.removeRange(length-cards.length, length);
            _updateList(index);
          }

      });
  }

  _updateList(int index) {
    // Show win if all card has been suited
    if (finalClubsDeck.length +
        finalSpadesDeck.length +
        finalDiamondsDeck.length +
        finalHeartsDeck.length == 52) {
      // show win
      _showWinDialog();
    }

    List<PlayingCard> fromColumn = cardColumnMap[index];
    setState(() {
      if (fromColumn.length != 0) {
        fromColumn[fromColumn.length-1]
            ..opened = true
            ..faceUp = true;
      }
    });
  }

  _showWinDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Congradulation"),
            content: Text("You win!!!!"),
            actions: <Widget>[
                RaisedButton(
                  child: Text("Play again"),
                  onPressed: () {
                    _initialCards();
                    Navigator.pop(context);
                  },
                )
            ],
          );
        },
    );
  }

}



