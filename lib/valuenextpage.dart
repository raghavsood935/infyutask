import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSharedPrefsValue extends StatefulWidget {
  @override
  State<ShowSharedPrefsValue> createState() => _ShowSharedPrefsValueState();
}

class _ShowSharedPrefsValueState extends State<ShowSharedPrefsValue> {
  var valuefromprefs;
  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      valuefromprefs = preferences.getString("value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: Text(
        "Value From Shared Preferences is: \n\n${valuefromprefs.toString().toUpperCase()}",
        style: TextStyle(fontSize: 18),
      )),
    );
  }
}
