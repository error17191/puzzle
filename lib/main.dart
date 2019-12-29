import 'dart:async';
import 'package:flutter/material.dart';
import 'drag_app.dart';
import 'puzzle_piece.dart';

void main() {

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}


class _MyApp extends State<MyApp>{
  void initState() {
    new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      seconds++;
      minutes = (seconds ~/ 60.0).toInt();
      setState(() {});
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(child: Text('Minutes : $minutes Seconds : ${seconds%60}')),
          centerTitle: true,
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

