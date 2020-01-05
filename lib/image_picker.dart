import 'package:flutter/material.dart';
import 'package:play_drag/MyApp.dart';
import 'appBar.dart';

var flowerImages = [
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

var batotImages=[
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

class ImagePicker extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<ImagePicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
//    double height= MediaQuery.of(context).size.height;
//    double width=MediaQuery.of(context).size.width;
      return Scaffold(
        appBar: appBar('Choose Photo'),
        body:
        ListView(
            children: <Widget>[
              Padding(child: GestureDetector(
                child: Image.asset('assets/images/batot.jpg',fit: BoxFit.fill,height: 200,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp(images:batotImages)));
                },
              ),
              padding: EdgeInsets.all(25),
              ),
              Padding(child: GestureDetector(
                child: Image.asset('assets/images/flower.jpg',fit: BoxFit.fill,height: 200,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp(images:flowerImages)));
                },
              ),padding: EdgeInsets.all(25),),
              Padding(child: GestureDetector(
                child: Image.asset('assets/images/flower.jpg',fit: BoxFit.fill,height: 200,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp(images:flowerImages)));
                },
              ),padding: EdgeInsets.all(25),)

            ])

      );
    }
  }

