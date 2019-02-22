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

  final mainList = [
    {
      "name": "Mines weeper",
      "target": Minesweeper()
    },
    {
      "name": "Solitaire",
      "target": Solitaire()
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: _buildList(),
    );
  }

  //
  // Subroutine
  //
  _buildList() {
    return Container(
      child: ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (context, id) {
              return Card(
                child: ListTile(
                  title: Text("${mainList[id]["name"]}"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => mainList[id]["target"],));
                  },
                ),
              );
          },
      ),
    );
  }
}


