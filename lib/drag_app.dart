import 'package:flutter/material.dart';
import 'dart:async';
import 'puzzle_piece.dart';

class DragApp extends StatefulWidget {
  var images;
  DragApp({this.images});

  @override
  _DragAppState createState() => _DragAppState();
}

class _DragAppState extends State<DragApp> {

  @override
  void initState() {
    widget.images.shuffle();
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
      future: _calculateImageDimension(widget.images),
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
                PuzzlePiece(0,widget.images),
                PuzzlePiece(1,widget.images),
                PuzzlePiece(2,widget.images),
                PuzzlePiece(3,widget.images),
                PuzzlePiece(4,widget.images),
                PuzzlePiece(5,widget.images),
                PuzzlePiece(6,widget.images),
                PuzzlePiece(7,widget.images),
                PuzzlePiece(8,widget.images)
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

Future<Size> _calculateImageDimension(images) {
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
