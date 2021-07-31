import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imageria/src/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double iconSize = 0.0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        iconSize = 0.2;
      });
    });
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          /* decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/icon/logo.png",
                  ))), */
          width: height * iconSize,
          height: height * iconSize,
          child: ClipOval(
            child: Image.asset(
              "assets/images/splash.png",
              /*  width: height * 0.2,
                height: height * 0.2, */
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
