import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Drag app"),
        ),
        body: HomePage(),
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
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DragTarget(builder: (BuildContext context, List incoming, List rejected) {
            print(rejected);
            print(incoming);
            return Text('1');
          },
          onWillAccept: (data) {
            print('test');
            print(data);
            return true;
          }),
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
              childWhenDragging: Container()),
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
