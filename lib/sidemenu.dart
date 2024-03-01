import 'package:flutter/material.dart';
import 'package:flutterdb/pages/attendedclass_page.dart';
import 'package:flutterdb/pages/class_pages.dart';
import 'package:flutterdb/pages/course_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        //color: Colors.red,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            menuitem("Courses", () {
              var route = MaterialPageRoute(builder: (context) {
                return CoursePage();
              });
              Navigator.of(context).pop();
              Navigator.of(context).push(route);
            }),
            menuitem(("Classes"), () {
              var route = MaterialPageRoute(builder: (context) {
                return const ClassPage();
              });
              Navigator.of(context).pop(); //leave from current page
              Navigator.of(context).push(route); //jump to new page
            }),
            menuitem(("Attended  Classes"), () {
              var route = MaterialPageRoute(builder: (context) {
                return const AttendedPage();
              });
              Navigator.of(context).pop(); //leave from current page
              Navigator.of(context).push(route); //jump to new page
            })
          ],
        )),
      ),
    );
  }

  Widget menuitem(String title, Function callback) {
    return InkWell(
      splashColor: Colors.blue,
      onTap: () {
        callback();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.book),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
