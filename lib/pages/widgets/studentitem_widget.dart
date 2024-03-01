import 'package:flutter/material.dart';
import 'package:flutterdb/model/student.dart';

class StudentItemWidget extends StatelessWidget {
  final Student student;
  Function? onDelete;
  StudentItemWidget(this.student, {this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Text("${student.id}. "), Text(student.name)]),
                IconButton(
                    onPressed: () {
                      if (onDelete != null) onDelete!(student);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            Row(children: [
              Text(student.email?.toString() ?? "_"),
              Text(student.phone ?? "   _")
            ]),
          ],
        ),
      ),
    );
  }
}
