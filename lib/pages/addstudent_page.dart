import 'package:flutter/material.dart';
import 'package:flutterdb/model/student.dart';
import 'package:flutterdb/services/dbmanager.dart';

class AddStudentPage extends StatefulWidget {
  Student? student;
  AddStudentPage({this.student, super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  var dbManager = DBManger.shared;
  String stdid = "";
  String name = "";
  String phone = "";
  String email = "";
  var isEditing = false;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEditing = widget.student != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${isEditing ? 'Edit Student' : 'Add new student'}"),
        actions: [IconButton(onPressed: save, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.student?.stdid,
                  validator: validateStdid,
                  onSaved: (value) {
                    stdid = value!;
                  },
                ),
                TextFormField(
                  initialValue: widget.student?.name,
                  validator: validateName,
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                TextFormField(
                  initialValue: widget.student?.phone,
                  validator: validatePh,
                  onSaved: (value) {
                    phone = value!;
                  },
                ),
                TextFormField(
                  initialValue: widget.student?.email,
                  validator: validateEmail,
                  onSaved: (value) {
                    email = value!;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateStdid(String? str) {
    if (str == null || str!.isEmpty) {
      return "Student ID must not be empty";
    } else if (str != null && str!.length < 5) {
      return "Student ID length must be greater than 4 ";
    }
    return null;
  }

  String? validateName(String? str) {
    if (str == null || str!.isEmpty) {
      return "Name must not be empty";
    } else if (str != null && str!.length < 5) {
      return "Name length must be greater than 4 ";
    }
    return null;
  }

  String? validatePh(String? str) {
    if (str == null || str!.isEmpty) {
      return "Phone must not be empty";
    } else if (str != null && str!.length < 9) {
      return "Phone length must be greater than 8 ";
    }
    return null;
  }

  String? validateEmail(String? str) {
    if (str == null || str.isEmpty) {
      return "Email must not be empty";
    } else if (str.length < 5) {
      return "Email length must be greater than 4 "; //a@a.c
    }
    return null;
  }

  //methods
  save() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final student = Student(stdid, name, phone, email);

      if (isEditing) {
        student.id = widget.student!.id; //**** */
        dbManager.updateStudent(student).then((std) {
          if (std != null) {
            print("Successfully Updated");
          }
        });
      } else {
        dbManager.addStudent(student).then((retID) {
          if (retID > 0) {
            formKey.currentState!.reset();
          }
        });
      }
    }
  }
}
