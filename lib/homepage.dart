import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_infyutask/demopage1.dart';
import 'package:flutter_infyutask/demopage2.dart';
import 'package:flutter_infyutask/bluetooth.dart';
import 'package:flutter_infyutask/valuenextpage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, Map<String, dynamic>>>? future;
  @override
  void initState() {
    super.initState();
    future = fetchData();
  }

  Future<Map<String, Map<String, dynamic>>> fetchData() async {
    final response =
        await http.get(Uri.parse("https://api.wazirx.com/api/v2/tickers"));
    if (response.statusCode == 200) {
      final responseJson = (json.decode(response.body) as Map).map(
          (key, value) =>
              MapEntry(key as String, value as Map<String, dynamic>));
      return responseJson;
    } else {
      throw Exception('Unexpected Error Occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "InfyU Labs",
          style: TextStyle(fontSize: 21),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Fluttertoast.showToast(msg: "Refreshing List !");
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Center(
                  child: Text('App Drawer',
                      style: TextStyle(fontSize: 21, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.deepPurple)),
                leading: Icon(Icons.image, color: Colors.deepPurple, size: 20),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DemoPage1()));
                },
                title: Text(
                  'Tap For Page 1',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.deepPurple)),
                leading:
                    Icon(Icons.icecream, color: Colors.deepPurple, size: 20),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DemoPage2()));
                },
                title: Text(
                  'Tap For Page 2',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.deepPurple)),
                leading:
                    Icon(Icons.bluetooth, color: Colors.deepPurple, size: 20),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Bluetooth()));
                },
                title: Text(
                  'Bluetooth Connect',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tap on any List Tile to save and show value from Shared Preferences on next page!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<Map<String, Map<String, dynamic>>>(
                future: future,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, Map<String, dynamic>>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Fetching Results From Api",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ));
                  }

                  final data = snapshot.data;

                  return ListView.builder(
                    itemBuilder: ((context, index) {
                      final title = data!.keys.elementAt(index);
                      final item = data.entries.elementAt(index);
                      final map = item.value;
                      final String baseUnit = map['base_unit'];
                      final String quoteUnit = map['quote_unit'];
                      final String high = map['high'];
                      final String low = map['low'];
                      final String type = map['type'];
                      final String volume = map['volume'];
                      final String buy = map['buy'];
                      final String sell = map['sell'];
                      final String name = map['name'];

                      return InkWell(
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setString(
                              "value", data.keys.elementAt(index).toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShowSharedPrefsValue()));
                        },
                        child: ListTile(
                          title: Text(title.toUpperCase()),
                          subtitle: Text(
                              'High- $high$quoteUnit  Low- $low$quoteUnit  Type- $type  Volume- $volume  Buy- $buy$quoteUnit  Sell- $sell$quoteUnit  Name- $name'),
                        ),
                      );
                    }),
                    itemCount: data!.entries.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
