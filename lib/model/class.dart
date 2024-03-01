class Class {
  int id = 0;
  String name = "";
  double startdate = 0.0;
  String get startdateString => "";

  Class.fromJSON(Map json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    startdate = json["startdate"] ?? 0;
    //number of second since 2000
  }
}
