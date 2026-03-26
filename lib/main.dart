import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:random_duck/screens/home.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Duckly",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: null),
      home: AnimatedSplashScreen(
        splash: "assets/splash/loader.gif",
        nextScreen: Home(),
        centered: true,
        splashIconSize: 320,
        backgroundColor: Colors.white,
        duration: 1500,
      ),
    );
  }
}
