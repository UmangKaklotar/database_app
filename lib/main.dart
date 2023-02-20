import 'package:database_app/helper/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              child: Text("Insert"),
              onPressed: () async {
                Map<String, dynamic> row = {
                  DatabaseHelper.columnName: "Umang",
                  DatabaseHelper.columnAge: "18",
                };
                final isInserted = await dbHelper.insert(row);
              },
            ),
            MaterialButton(
              child: Text("Read"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
