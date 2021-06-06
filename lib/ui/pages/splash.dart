import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        height: size.height,
        width: size.width,


        child:SplashScreen(
          title: Text(''),

          seconds: 50,
          image: new Image.asset('assets/1.jpg',
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 110.0,
          onClick: () {},
          loaderColor: Colors.red,

        ),



      ),
    );
  }
}

