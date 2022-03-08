import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoPage2 extends StatefulWidget {
  @override
  State<DemoPage2> createState() => _DemoPage2State();
}

class _DemoPage2State extends State<DemoPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hey There !",
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 70,
            ),
            Image.asset("images/demo2.png", fit: BoxFit.cover),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.black,
                width: 1.5, // Underline thickness
              ))),
              child: Text(
                "InfyU Labs",
                style: TextStyle(
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "This is Page 2",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "by Raghav",
              style: TextStyle(
                fontFamily: GoogleFonts.lato().fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ));
  }
}
