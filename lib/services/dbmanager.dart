import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutterdb/model/attendedclass.dart';
import 'package:flutterdb/model/class.dart';
import 'package:flutterdb/model/course.dart';
import 'package:flutterdb/model/student.dart';
import 'package:sqflite/sqflite.dart';

class DBManger {
  static var shared =
      DBManger(); // Singleton to make lesser instance and more control
  final dbfile = 'trainingschooldb.db';
  late Database database;

  Future<void> prepareDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = dbDir + "/" + dbfile;
    var file = File(dbPath);
    var isFileExist = await file.exists();

    if (isFileExist) {
      print("File already exist and use it");
    } else {
      print("Copying....bundle to the dbpath");
      ByteData data = await rootBundle.load("assets/$dbfile");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }
    //
    database = await openDatabase(dbPath);
    print("DB Ready");

    return;
  }

//course methods
  Future<List<Course>> loadCourses() async {
    List<Course> courses = [];
    List<Map<String, Object?>> courseListMap =
        await database.query("Course", orderBy: "id");
    courseListMap.forEach((element) {
      courses.add(Course.fromJSON(element));
    });
    return courses;
  }

  //course methods
  Future<List<Class>> loadClasses() async {
    List<Class> classes = [];
    List<Map<String, Object?>> classListMap =
        await database.query("Class", orderBy: "id");
    classListMap.forEach((element) {
      classes.add(Class.fromJSON(element));
    });
    return classes;
  }

  Future<List<AttendedClass>> loadAttendClasses() async {
    List<AttendedClass> classes = [];

    final sql = AttendedClass.kAttendClassQueryStatement;
    List<Map<String, Object?>> attendClassListMap =
        await database.rawQuery(sql);
    print(attendClassListMap);
    attendClassListMap.forEach((element) {
      classes.add(AttendedClass.fromJSON(element));
    });
    return classes;
    //return classes;
  }

//Students methods
  Future<List<Student>> loadStudents() async {
    List<Student> students = [];
    List<Map<String, Object?>> studentListMap =
        await database.query("Student", orderBy: "id");
    studentListMap.forEach((element) {
      students.add(Student.fromJSON(element));
    });
    return students;
  }

  Future<int> addStudent(Student student) async {
    var retID = await database.insert("Student", {
      "stdid": student.stdid,
      "name": student.name,
      "ph": student.phone,
      "email": student.email
    });
    print("Insert student return:$retID ...");
    return retID;
  }

  Future<bool> removeStudent(Student student) async {
    //considered soft deleted
    var retID = await database.delete("Student", where: "id = ${student.id}");
    return retID > 0;
  }

  Future<Student?> updateStudent(Student student) async {
    var retID = await database.update(
        "Student",
        {
          "stdid": student.stdid,
          "name": student.name,
          "ph": student.phone,
          "email": student.email,
        },
        where: "id == ${student.id}");
    print("updated student return:$retID ...");
    return retID > 0 ? student : null;
  }
}
