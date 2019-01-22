///
/// Just use dto practice
///
import 'package:flutter/material.dart';

import 'package:flutter_game/game/minesweeper/mines_weeper.dart';
import 'package:flutter_game/game/solitaire/solitaire.dart';

class GameList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameListState();
  }

}

class _GameListState extends State<GameList> {

  static final  String _ITEM_1 = "Mines weeper";
  static final String _ITEM_2 = "Solitaire";


  final list = <String>[
    _ITEM_1,
    _ITEM_2,
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, id) => Card(
          child: ListTile(
            title: Text("${list[id]}"),
            onTap: () {
              if (list[id] == _ITEM_1) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Minesweeper(),));
              } else if (list[id] == _ITEM_2) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Solitaire(),));
              }
            },
          ),
        ),
      ),
    );
  }

}


