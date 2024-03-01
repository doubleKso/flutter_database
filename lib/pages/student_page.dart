import 'package:flutter/material.dart';
import 'package:flutterdb/pages/addstudent_page.dart';
import 'package:flutterdb/pages/widgets/studentitem_widget.dart';
import 'package:flutterdb/services/dbmanager.dart';
import 'package:flutterdb/sidemenu.dart';

import '../model/student.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  var dbManger = DBManger.shared; //** */
  List<Student> students = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbManger.prepareDB().then((value) => loadStudent()); //** */
  }

  loadStudent() async {
    var test = await dbManger.loadAttendClasses();
    students = await dbManger.loadStudents(); //** */
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Students"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                toAddNewStudent(context);
              })
        ],
      ),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var std = students[index];
          return InkWell(
            onTap: () {
              toEditStudent(context, std);
            },
            child: StudentItemWidget(std, onDelete: (std) {
              dbManger.removeStudent(std).then((status) {
                if (status) loadStudent();
              });
            }),
          );
        },
        itemCount: students.length,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  toEditStudent(BuildContext context, Student student) {
    var route = MaterialPageRoute(builder: (context) {
      return AddStudentPage(student: student);
    });
    Navigator.push(context, route).then((value) => loadStudent());
  }

  toAddNewStudent(BuildContext context) {
    var route = MaterialPageRoute(builder: (context) {
      return AddStudentPage();
    });
    Navigator.push(context, route).then((value) => loadStudent());
  }
}
