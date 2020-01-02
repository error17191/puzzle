import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

List<PuzzlePiece> puzzlePieces = List<PuzzlePiece>();
List<_PuzzlePieceState> pieceStates = List<_PuzzlePieceState>();
double inBetweenDistance;
double sideMargin;
double imageWidth;
double imageHeight;
double offsetTop;
double unusableHeight;
int minutes = 0;
int seconds = 0;

var images = [
  {'order': 0, 'path': 'assets/images/image1_1.jpg'},
  {'order': 1, 'path': 'assets/images/image1_2.jpg'},
  {'order': 2, 'path': 'assets/images/image1_3.jpg'},
  {'order': 3, 'path': 'assets/images/image1_4.jpg'},
  {'order': 4, 'path': 'assets/images/image1_5.jpg'},
  {'order': 5, 'path': 'assets/images/image1_6.jpg'},
  {'order': 6, 'path': 'assets/images/image1_7.jpg'},
  {'order': 7, 'path': 'assets/images/image1_8.jpg'},
  {'order': 8, 'path': 'assets/images/image1_9.jpg'},
];

class PuzzlePiece extends StatefulWidget {
  int i;

  PuzzlePiece(this.i);

  @override
  _PuzzlePieceState createState() {
    double top, left;
    if (i < 3) {
      top = offsetTop;
    } else if (i < 6) {
      top = offsetTop + imageHeight + inBetweenDistance;
    } else {
      top = offsetTop + imageHeight * 2 + inBetweenDistance * 2;
    }

    if (i == 0 || i == 3 || i == 6) {
      left = sideMargin;
    } else if (i == 1 || i == 4 || i == 7) {
      left = sideMargin + imageWidth + inBetweenDistance;
    } else {
      left = sideMargin + 2 * imageWidth + 2 * inBetweenDistance;
    }
    return _PuzzlePieceState(
        i, images[i]['path'], top, left, images[i]['order']);
  }
}

class _PuzzlePieceState extends State<PuzzlePiece> {
  String imagePath;
  double left;
  double top;
  int index;
  int order;

  _PuzzlePieceState(index, imagePath, top, left, order) {
    this.index = index;
    this.imagePath = imagePath;
    this.top = top;
    this.left = left;
    this.order = order;
    pieceStates.add(this);
  }

  String getImagePath() {
    return imagePath;
  }

  void updateImage(path, order) {
    setState(() {
      imagePath = path;
      this.order = order;
    });
  }

  Map get position {
    return {'top': top, 'left': left};
  }

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      imagePath,
      width: imageWidth,
    );

    return Positioned(
      width: imageWidth,
      top: top,
      left: left,
      child: Draggable(
        onDragEnd: (details) {
          for (var i = 0; i < pieceStates.length; i++) {
            if (i == index) {
              continue;
            }
            if ((pieceStates[i].position['left'] - details.offset.dx).abs() <
                    imageWidth / 2 &&
                (pieceStates[i].position['top'] -
                            (details.offset.dy - unusableHeight))
                        .abs() <
                    imageHeight / 2) {
              String currentImagePath = imagePath;
              int currentOrder = order;
              updateImage(pieceStates[i].getImagePath(), pieceStates[i].order);
              pieceStates[i].updateImage(currentImagePath, currentOrder);
              break;
            }
          }
          if (puzzleCompleted()) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("CONGRATULATIONS"),
                    content:
                        new Text("GAME FINISHED IN $minutes : ${seconds % 60}"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        color: Colors.blue,
                        child: new Text("Restart"),
                        onPressed: () {
                          images.shuffle();
                          for (int i = 0; i < pieceStates.length; i++) {
                            pieceStates[i].updateImage(images[i]['path'], images[i]['order']);
                          }
                          setState(() {
                            minutes = 0;
                            seconds = 0;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          }
        },
        child: image,
        feedback: image,
        childWhenDragging: Container(),
      ),
    );
  }
}

bool puzzleCompleted() {
  for (int i = 0; i < pieceStates.length; i++) {
    if (i != pieceStates[i].order) {
      return false;
    }
  }
  return true;
}
