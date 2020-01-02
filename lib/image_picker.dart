import 'package:flutter/material.dart';
import 'appBar.dart';
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
                  Navigator.push(context, MaterialPageRoute());
                },
              ),
              padding: EdgeInsets.all(25),
              ),
              Padding(child: GestureDetector(
                child: Image.asset('assets/images/flower.jpg',fit: BoxFit.fill,height: 200,),
                onTap: ()=>print('no'),
              ),padding: EdgeInsets.all(25),),
              Padding(child: GestureDetector(
                child: Image.asset('assets/images/flower.jpg',fit: BoxFit.fill,height: 200,),
                onTap: ()=>print('no'),
              ),padding: EdgeInsets.all(25),)

            ])

      );
    }
  }

