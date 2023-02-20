import 'package:database_app/helper/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Employee> employee = [];
  List searchList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    databaseHelper.getEmployee().then((e) {
      employee.addAll(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child:  CupertinoSearchTextField(
                controller: searchController,
                backgroundColor: Colors.grey.shade300,
                onChanged: (val) {
                  for(int i = 0 ; i < employee.length ; i++) {
                    String data = employee[i].name!.toUpperCase().toString();
                    if(employee[i].name!.contains(searchController.text)) {
                      print(employee[i].name);
                    }
                  }
                },
              ),
            ),
            CupertinoButton.filled(
              child: const Text("Insert"),
              onPressed: () async {
                Map<String, dynamic> row = {
                  DatabaseHelper.columnName: "Umang",
                  DatabaseHelper.columnAge: "18",
                };
                var emp = Employee(name: 'Sanjay', age: '18');
                await databaseHelper.insertData(emp);
              },
            ),
            CupertinoButton.filled(
              child: const Text("Read"),
              onPressed: () async {
                await databaseHelper.readData();
              },
            ),
            CupertinoButton.filled(
              child: const Text("Update"),
              onPressed: () async {
               Map<String, dynamic> row = {
                 DatabaseHelper.columnName: "Shreya",
                 DatabaseHelper.columnAge: "20",
               };
                await databaseHelper.updateData(
                 id: '5',
                 row: row,
                 table: DatabaseHelper.table,
               );
              },
            ),
            CupertinoButton.filled(
              child: const Text("Delete"),
              onPressed: () async {
                await databaseHelper.deleteData(6);
              },
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: FutureBuilder<List<Employee>>(
                  future: databaseHelper.getEmployee(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Name : ${snapshot.data![index].name}"),
                            subtitle: Text("Age : ${snapshot.data![index].age}"),
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError) {
                      return Text("${snapshot.hasError}");
                    }
                    // else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    // }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
