class Course {
  //{id: 3, stdid: MDY0001, name: May Hnin, ph: , email: }
  int id = 0;
  String title = "";
  String desc = "";
  int duration = 0;

  Course.fromJSON(Map json) {
    id = json["id"] ?? 0;
    title = json["title"] ?? "";
    desc = json["desc"] ?? "";
    duration = json["duration"] ?? 0;
  }
}
