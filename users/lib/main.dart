import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Lista de usuarios'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late Map data;
   late List usersData;

  getUsers() async {
    http.Response response =
        await http.get(Uri.parse('http://10.0.2.2:4000/api/users'));
    data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return (Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "$index",
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(usersData[index]['avatar']),
                  ),
                  Padding(padding: const EdgeInsets.all(10.0),
                  child: Text("${usersData[index]["lastName"]} ${usersData[index]["lastName"]}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700
                  ),),
                  )
                ],
              ),
            ),
          ));
        },
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
