///
/// Used to practice
///
import 'package:flutter/material.dart';

enum CardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

enum CardType {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
}

enum CardColor {
  red,
  black,
}

// Playing card model
class PlayingCard {
  CardSuit cardSuit;
  CardType cardType;
  bool faceUp;
  bool opened;

  PlayingCard({
    @required this.cardSuit,
    @required this.cardType,
    this.faceUp = false,
    this.opened = false
  });

  Color get cardColor {
    if (cardSuit == CardSuit.hearts ||
        cardSuit == CardSuit.diamonds) {
      return Colors.red;
    }

    return Colors.black;
   }

   String get typeToString {
      switch (cardType) {
        case CardType.one:
          return "1";
        case CardType.two:
          return "2";
        case CardType.three:
          return "3";
        case CardType.four:
          return "4";
        case CardType.five:
          return "5";
        case CardType.six:
          return "6";
        case CardType.seven:
          return "7";
        case CardType.eight:
          return "8";
        case CardType.nine:
          return "9";
        case CardType.ten:
          return "10";
        case CardType.jack:
          return "J";
        case CardType.queen:
          return "Q";
        case CardType.king:
          return "K";
        default:
            return "";
      }
   }

   String get suitToString {
      switch (cardSuit) {
        case CardSuit.diamonds:
          return "D";
        case CardSuit.hearts:
          return "H";
        case CardSuit.clubs:
          return "C";
        case CardSuit.spades:
          return "S";
        default:
          return "";
      }
   }


}


