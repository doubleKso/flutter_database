class AttendedClass {
  static final kAttendClassQueryStatement =
      ''' SELECT AttendedClass.id ,AttendedClass.stdid,Student.name as stdname,classid,Class.name as classname ,courseid,title as coursetitle FROM  AttendedClass  INNER JOIN  Course   
    ON AttendedClass.courseid = Course.id INNER JOIN Class ON AttendedClass.classid = Class.id  
    INNER JOIN Student on AttendedClass.stdid = Student.id Order by stdname  ASC''';
  int id = 0;

  int courseid = 0;
  String courseTitle = "";
  int classid = 0;
  String className = "";
  int stdid = 0;
  String stdName = "";

  AttendedClass.fromJSON(Map json) {
    id = json["id"] ?? 0;
    courseid = json["courseid"] ?? "";
    courseTitle = json["coursetitle"] ?? "";
    classid = json["classid"] ?? "";
    className = json["classname"] ?? "";
    stdid = json["stdid"] ?? 0;
    stdName = json["stdname"] ?? "";
  }
}
