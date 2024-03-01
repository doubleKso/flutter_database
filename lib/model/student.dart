class Student {
  //{id: 3, stdid: MDY0001, name: May Hnin, ph: , email: }
  int id = 0;
  late String stdid;
  late String name;
  String? phone;
  String? email;
  // construtor
  Student(this.stdid, this.name, this.phone, this.email);

  Student.fromJSON(Map json) {
    id = json["id"] ?? 0;
    stdid = json["stdid"] ?? "";
    name = json["name"] ?? "";
    phone = json["phone"];
    email = json["email"];
  }
}
