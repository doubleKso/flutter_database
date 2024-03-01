import 'package:flutter/material.dart';
import 'package:flutterdb/model/attendedclass.dart';
import 'package:flutterdb/model/course.dart';
import 'package:flutterdb/services/dbmanager.dart';
import 'package:flutterdb/sidemenu.dart';

import '../model/student.dart';

class AttendedPage extends StatefulWidget {
  const AttendedPage({super.key});

  @override
  State<AttendedPage> createState() => _AttendedPageState();
}

class _AttendedPageState extends State<AttendedPage> {
  var dbManger = DBManger.shared; //** */
  List<AttendedClass> attClasses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAttended(); //** */
  }

  loadAttended() async {
    attClasses = await dbManger.loadAttendClasses(); //** */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Attended Class"),
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          var attClass = attClasses[index];
          return Card(
            child: Wrap(children: [
              Text(attClass.stdName.toString()),
              Text(attClass.className),
              Text(attClass.courseTitle)
            ]),
          );
        },
        itemCount: attClasses.length,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
