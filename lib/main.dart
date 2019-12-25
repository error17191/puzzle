import 'package:flutter/material.dart';

List<PuzzlePiece> puzzlePieces = List<PuzzlePiece>();
List<_PuzzlePieceState> pieceStates = List<_PuzzlePieceState>();
double inBetweenDistance;
double sideMargin;
double pieceDimention;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragApp(),
    );
  }
}

class AnyThing {}

class DragApp extends StatefulWidget {
  @override
  _DragAppState createState() => _DragAppState();
}

class _DragAppState extends State<DragApp> {
  @override
  Widget build(BuildContext context) {
    pieceDimention = MediaQuery.of(context).size.width * 0.3;
    sideMargin = MediaQuery.of(context).size.width * 0.03;
    inBetweenDistance = MediaQuery.of(context).size.width * 0.02;

    puzzlePieces.add(PuzzlePiece(0, 'assets/images/1.jpg', 100.0, sideMargin));
    puzzlePieces.add(PuzzlePiece(1, 'assets/images/2.jpg', 100.0,
        sideMargin + pieceDimention + inBetweenDistance));
    puzzlePieces.add(PuzzlePiece(2, 'assets/images/3.jpg', 100.0,
        sideMargin + pieceDimention * 2 + inBetweenDistance * 2));
    puzzlePieces.add(PuzzlePiece(3, 'assets/images/4.jpg', 200.0, sideMargin));
    puzzlePieces.add(PuzzlePiece(4, 'assets/images/5.jpg', 200.0,
        sideMargin + pieceDimention + inBetweenDistance));
    puzzlePieces.add(PuzzlePiece(5, 'assets/images/6.jpg', 200.0,
        sideMargin + pieceDimention * 2 + inBetweenDistance * 2));
    puzzlePieces.add(PuzzlePiece(6, 'assets/images/7.jpg', 300.0, sideMargin));
    puzzlePieces.add(PuzzlePiece(7, 'assets/images/8.jpg', 300.0,
        sideMargin + pieceDimention + inBetweenDistance));
    puzzlePieces.add(PuzzlePiece(8, 'assets/images/9.jpg', 300.0,
        sideMargin + pieceDimention * 2 + inBetweenDistance * 2));

    return Stack(
      children: [
        puzzlePieces[0],
        puzzlePieces[1],
        puzzlePieces[2],
        puzzlePieces[3],
        puzzlePieces[4],
        puzzlePieces[5],
        puzzlePieces[6],
        puzzlePieces[7],
        puzzlePieces[8],
      ],
    );
  }
}

class PuzzlePiece extends StatefulWidget {
  String imagePath;
  double left;
  double top;
  int index;
  _PuzzlePieceState _state;

  Map get position {
    return {'top': top, 'left': left};
  }

  String getImagePath() {
    return _state.getImagePath();
  }

  void setImagePath(path) {
    _state.setImagePath(path);
  }

  PuzzlePiece(index, imagePath, top, left) {
    this.index = index;
    this.imagePath = imagePath;
    this.top = top;
    this.left = left;
  }

  @override
  _PuzzlePieceState createState() {
    _state = _PuzzlePieceState(this.index, this.imagePath, this.top, this.left);
    return _state;
  }
}

class _PuzzlePieceState extends State<PuzzlePiece> {
  String imagePath;
  double left;
  double top;
  int index;

  _PuzzlePieceState(index, imagePath, top, left) {
    this.index = index;
    this.imagePath = imagePath;
    this.top = top;
    this.left = left;
    pieceStates.add(this);
  }

  String getImagePath() {
    return imagePath;
  }

  void setImagePath(path) {
    setState(() {
      imagePath = path;
    });
  }

  Map get position {
    return {'top': top, 'left': left};
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: pieceDimention,
      top: top,
      left: left,
      child: Draggable(
        onDragEnd: (details) {
          for (var i = 0; i < pieceStates.length; i++) {
            if (i == index) {
              continue;
            }
            print((pieceStates[i].position['left'] - this.left).abs());
            print(imagePath);
            print(pieceStates[i].getImagePath());
            if ((pieceStates[i].position['left'] - details.offset.dx).abs() <
                pieceDimention / 2 && (pieceStates[i].position['top'] - details.offset.dy).abs() <
                pieceDimention / 2) {
              String currentImagePath = imagePath;
              setImagePath(pieceStates[i].getImagePath());
              pieceStates[i].setImagePath(currentImagePath);
            }
          }
        },
        onDragCompleted: () {},
        child: Image.asset(
          imagePath,
        ),
        feedback: Image.asset(
          imagePath,
          width: pieceDimention,
        ),
        childWhenDragging: Container(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double width = 100.0, height = 100.0;
  Offset position;

  @override
  void initState() {
    super.initState();
    position = Offset(0.0, height - 20);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.black,
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DragTarget(
                builder: (
                  BuildContext context,
                  List incoming,
                  List rejected,
                ) {
                  return Text('1');
                },
                onWillAccept: (data) {
                  return true;
                },
              ),
              Draggable(
                data: 1,
                child: Container(
                  child: Image.asset('assets/images/1.jpg',
                      width: width / 4.0, height: height / 4.0),
                ),
                feedback: Container(
                  child: Image.asset('assets/images/1.jpg',
                      width: width / 4.0, height: height / 4.0),
                ),
                childWhenDragging: Container(),
              ),
              DragTarget(
                builder: (BuildContext context, incoming, rejected) {
                  return Text('1');
                },
              ),
              Draggable(
                  data: 2,
                  child: Container(
                    child: Image.asset('assets/images/2.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(
                    child: Image.asset('assets/images/2.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  childWhenDragging: Container()),
              DragTarget(
                builder: (BuildContext context, incoming, rejected) {
                  return Text('1');
                },
              ),
              Draggable(
                  data: 3,
                  child: Container(
                    child: Image.asset('assets/images/3.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(
                    child: Image.asset('assets/images/3.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  childWhenDragging: Container())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Draggable(
                  data: 4,
                  child: Container(
                    child: Image.asset('assets/images/4.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(
                    child: Image.asset('assets/images/4.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  childWhenDragging: Container()),
              Draggable(
                  data: 5,
                  child: Container(
                    child: Image.asset('assets/images/5.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(
                    child: Image.asset('assets/images/5.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  childWhenDragging: Container()),
              Draggable(
                  data: 6,
                  child: Container(
                    child: Image.asset('assets/images/6.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(
                    child: Image.asset('assets/images/6.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  childWhenDragging: Container()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Draggable(
                  data: 7,
                  child: Container(
                    child: Image.asset('assets/images/7.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Container(),
                  childWhenDragging: Container()),
              Draggable(
                data: 8,
                child: Container(
                  child: Image.asset('assets/images/8.jpg',
                      width: width / 4.0, height: height / 4.0),
                ),
                feedback: Container(),
                childWhenDragging: Container(),
              ),
              Draggable(
                  data: 9,
                  child: Container(
                    child: Image.asset('assets/images/9.jpg',
                        width: width / 4.0, height: height / 4.0),
                  ),
                  feedback: Image.asset('assets/images/9.jpg',
                      width: width / 4.0, height: height / 4.0),
                  childWhenDragging: Container()),
            ],
          )
        ]));

//   return   Stack(
//      children: <Widget>[
//        Positioned(
//          left: position.dx,
//          top: position.dy - height + 20,
//          child: Draggable(
//            child: Container(
//              width: width,
//              height: height,
//              color: Colors.blue,
//              child: Center(child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
//            ),
//            feedback: Container(
//              child: Center(
//                child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
//              color: Colors.blue[300],
//              width: width,
//              height: height,
//            ),
//            onDraggableCanceled: (Velocity velocity, Offset offset){
//              setState(() => position = offset);
//            },
//          ),
//        ),
//      ],
//    );
  }
}
