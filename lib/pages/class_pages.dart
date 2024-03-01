import 'package:flutter/material.dart';
import 'package:flutterdb/model/class.dart';
import 'package:flutterdb/model/course.dart';
import 'package:flutterdb/services/dbmanager.dart';
import 'package:flutterdb/sidemenu.dart';

import '../model/student.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  var dbManger = DBManger.shared; //** */
  List<Class> courses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadClass(); //** */
  }

  loadClass() async {
    courses = await dbManger.loadClasses(); //** */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Classes"),
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          var currClass = courses[index];
          return Card(
            child: Row(children: [
              Text(currClass.id.toString()),
              Text(currClass.name)
            ]),
          );
        },
        itemCount: courses.length,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
