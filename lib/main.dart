import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InfyU Labs Task',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      home: SplashToHomePage(),
    );
  }
}

class SplashToHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: GoogleFonts.lato().fontFamily),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: AnimatedSplashScreen(
          nextScreen: HomePage(),
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "images/splash.png",
                height: 250,
                width: 300,
              ),
              Expanded(
                child: Text("Splash Screen",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: GoogleFonts.lato().fontFamily)),
              ),
            ],
          ),
          splashIconSize: 350,
          backgroundColor: Color.fromARGB(167, 19, 17, 17),
          splashTransition: SplashTransition.slideTransition,
          duration: 2500,
        ));
  }
}
