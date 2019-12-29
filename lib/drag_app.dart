import 'package:flutter/material.dart';
import 'dart:async';
import 'puzzle_piece.dart';

class DragApp extends StatefulWidget {
  @override
  _DragAppState createState() => _DragAppState();
}

class _DragAppState extends State<DragApp> {

  @override
  void initState() {
    images.shuffle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                  2 -
              unusableHeight;
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
