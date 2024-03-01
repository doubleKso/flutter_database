import 'package:flutter/material.dart';
import 'package:flutterdb/model/course.dart';
import 'package:flutterdb/services/dbmanager.dart';
import 'package:flutterdb/sidemenu.dart';

import '../model/student.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var dbManger = DBManger.shared; //** */
  List<Course> courses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCourse(); //** */
  }

  loadCourse() async {
    courses = await dbManger.loadCourses(); //** */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Courses"),
      ),

      body: ListView.builder(
        itemBuilder: (context, index) {
          var course = courses[index];
          return Card(
            child:
                Row(children: [Text(course.id.toString()), Text(course.title)]),
          );
        },
        itemCount: courses.length,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
