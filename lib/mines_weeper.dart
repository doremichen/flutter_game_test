import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';
import 'dart:math';

import 'package:flutter_game/board_square.dart';
import 'package:flutter_game/cust_item.dart';

class Minesweeper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinesweeperState();
  }

}

class _MinesweeperState extends State<Minesweeper> {

  bool _canVibrate = true;
//  final Iterable<Duration> pauses = [
//    const Duration(milliseconds: 500),
//    const Duration(milliseconds: 1000),
//    const Duration(milliseconds: 500),
//  ];

  int rowCount = 10;
  int columnCount = 10;

  // 2D list
  List<List<BoardSquare>> board;

  // bomb counter
  int bombCount = 0;

  // Opened: refers to being clicked already
  List<bool> openedSquares;

  // A flagged square is a square a user has added a flag on by long pressing
  List<bool> flaggedSquares;


  int sqauresLeft = 0;

  Card card = null;

  @override
  void initState() {
    super.initState();

    _initVib();
    _initialLayout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
        ),
        itemBuilder: (context, position) {
          int rowNumber = (position/columnCount).floor();
          int colmunNumber = (position%columnCount);

          CustItem item;

          if (openedSquares[position] == false) {
            if (flaggedSquares[position] == true) {
              item = CustItem(backGroundColor: Colors.yellow, info: "O",);
            } else {
              item = CustItem(backGroundColor: Colors.grey, info: "X",);
            }
          } else {
            if (board[rowNumber][colmunNumber].hasBomb) {
              item = CustItem(backGroundColor: Colors.red, info: "B",);

            } else {
              item = CustItem(backGroundColor: Colors.orange, info: "${board[rowNumber][colmunNumber].bombsAround}",);
            }
          }

          return GestureDetector(
            child: Card(
              color: Colors.grey,
              child: Center(
                child: item,
              ),
            ),
            onTap: () {

              print("bombCount: $bombCount");
              print("sqauresLeft: $sqauresLeft");

              if (board[rowNumber][colmunNumber].hasBomb) {
                _handleGameOver(context);

                setState(() {
                  openedSquares[position] = true;
                  sqauresLeft = sqauresLeft - 1;
                });

                return;
              }

              if (board[rowNumber][colmunNumber].bombsAround == 0) {
                _handleTap(rowNumber, colmunNumber);
              } else {
                setState(() {
                  openedSquares[position] = true;
                  sqauresLeft = sqauresLeft - 1;
                });
              }

              if (sqauresLeft <= bombCount) {
                _handleGameWin(context);
              }
            },
            onLongPress: () {
              if (openedSquares[position] == false) {
                setState(() {
                  flaggedSquares[position] = true;
                });
              }
            },
          );

        },
        itemCount: rowCount*columnCount,
      ),
    );
  }

  //
  // private subroutine section
  //
  _initVib() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
//      _canVibrate
//          ? print("This device can vibrate")
//          : print("This device cannot vibrate");
    });
  }

  _initialLayout() {
    // initialise 2d list
    board = List.generate(rowCount, (i) {
      return List.generate(columnCount, (j) {
        return BoardSquare();
      });
    });

    //reset bombCount
    bombCount = 0;

    // record squareLeft
    sqauresLeft = rowCount*columnCount;

    openedSquares = List.generate(rowCount*columnCount, (i) {
      return false;
    });

    flaggedSquares = List.generate(rowCount*columnCount, (i) {
      return false;
    });

    _generateBombOnSquares();

    _checkBombOnSquares();
  }


  _generateBombOnSquares() {
    // Generate bombs on squares
    int bombProbability = 3;
    int maxProbability = 15;

    Random random = Random();

    // Generate randomly for each square
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0 ;  j< columnCount; j++) {
        int randomInteger = random.nextInt(maxProbability);
        // less than bombProbability get bomb
        if (randomInteger < bombProbability) {
          board[i][j].hasBomb = true;

          // count bomb
          bombCount++;
        }
      }
    }
  }

  _checkBombOnSquares() {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (i > 0 && j > 0) {
          if (board[i - 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0) {
          if (board[i - 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0 && j < columnCount - 1) {
          if (board[i - 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j > 0) {
          if (board[i][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j < columnCount - 1) {
          if (board[i][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j > 0) {
          if (board[i + 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1) {
          if (board[i + 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < rowCount - 1 && j < columnCount - 1) {
          if (board[i + 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }
      }
    }
  }

  _handleTap(int i, int j) {

    int position = (i*columnCount) + j;
    openedSquares[position] = true;
    sqauresLeft = sqauresLeft-1;

    if (i > 0) {
      if (!board[i - 1][j].hasBomb &&
          openedSquares[((i - 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i - 1, j);
        }
      }
    }

    if (j > 0) {
      if (!board[i][j - 1].hasBomb &&
          openedSquares[(i * columnCount) + j - 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j - 1);
        }
      }
    }

    if (j < columnCount - 1) {
      if (!board[i][j + 1].hasBomb &&
          openedSquares[(i * columnCount) + j + 1] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i, j + 1);
        }
      }
    }

    if (i < rowCount - 1) {
      if (!board[i + 1][j].hasBomb &&
          openedSquares[((i + 1) * columnCount) + j] != true) {
        if (board[i][j].bombsAround == 0) {
          _handleTap(i + 1, j);
        }
      }
    }

    setState(() {});

  }

  _handleGameOver(BuildContext context) {

    if (_canVibrate) {
      Vibrate.vibrate();
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text("Game"),
          content: Text("Game over"),
          actions: <Widget>[
            RaisedButton(
              child: Text("Ok", style: TextStyle(color: Colors.white),),
              onPressed: () {

                _initialLayout();

                setState(() {

                });

                Navigator.pop(context);
              },
            )
          ],
        ),
    );
  }

  _handleGameWin(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text("Game"),
        content: Text("You win"),
        actions: <Widget>[
          RaisedButton(
            child: Text("Ok", style: TextStyle(color: Colors.white),),
            onPressed: () {

              _initialLayout();

              setState(() {

              });

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

}