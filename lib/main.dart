import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:rflutter_alert/rflutter_alert.dart';

List<PuzzlePiece> puzzlePieces = List<PuzzlePiece>();
List<_PuzzlePieceState> pieceStates = List<_PuzzlePieceState>();
double inBetweenDistance;
double sideMargin;
double imageWidth;
double imageHeight;
double offsetTop;
double unusableHeight;

var images = [
  {'order': 0, 'path': 'assets/images/1.jpg'},
  {'order': 1, 'path': 'assets/images/2.jpg'},
  {'order': 2, 'path': 'assets/images/3.jpg'},
  {'order': 3, 'path': 'assets/images/4.jpg'},
  {'order': 4, 'path': 'assets/images/5.jpg'},
  {'order': 5, 'path': 'assets/images/6.jpg'},
  {'order': 6, 'path': 'assets/images/7.jpg'},
  {'order': 7, 'path': 'assets/images/8.jpg'},
  {'order': 8, 'path': 'assets/images/9.jpg'},
];

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('a7la messa')),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              unusableHeight = MediaQuery.of(context).size.height -
                  constraints.constrainHeight();
              return DragApp();
            },
          ),
        ),
      ),
    );
  }
}

class DragApp extends StatefulWidget {
  @override
  _DragAppState createState() => _DragAppState();
}

class _DragAppState extends State<DragApp> {
  int seconds = 0;
  int minutes = 0;

  @override
  void initState() {
    new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      seconds++;
      minutes = (seconds ~/ 60.0).toInt();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    images.shuffle();
    inBetweenDistance = 2;
    double widthWithoutMargins =
        MediaQuery.of(context).size.width - 2 * inBetweenDistance;
    imageWidth = widthWithoutMargins * 0.32;
    sideMargin = widthWithoutMargins * 0.02;

    return FutureBuilder<Size>(
      future: _calculateImageDimension(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
        if (snapshot.hasData) {
          imageHeight = snapshot.data.height * imageWidth / snapshot.data.width;
          offsetTop = (MediaQuery.of(context).size.height -
                  (imageHeight * 3 + inBetweenDistance * 3)) /
              2 - unusableHeight;
          return Container(
            color: Colors.red,
            child: Stack(
              children: [
                PuzzlePiece(0),
                PuzzlePiece(1),
                PuzzlePiece(2),
                PuzzlePiece(3),
                PuzzlePiece(4),
                PuzzlePiece(5),
                PuzzlePiece(6),
                PuzzlePiece(7),
                PuzzlePiece(8)
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

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
            var timer = Timer(Duration(seconds: 1), () {
              Alert(
                context: context,
                type: AlertType.success,
                title: "Congratulations",
                desc: "You have Completed the puzzle successfully",
                buttons: [
                  DialogButton(
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
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

Future<Size> _calculateImageDimension() {
  Completer<Size> completer = Completer();
  Image image = Image.asset(images[0]['path']);
  image.image.resolve(ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        var myImage = image.image;
        Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      },
    ),
  );
  return completer.future;
}
