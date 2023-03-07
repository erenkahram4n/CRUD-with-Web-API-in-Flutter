class Personel {
  int id;
  String name;
  String surname;
  num salary;

  Personel(
      {required this.id,
      required this.name,
      required this.surname,
      required this.salary});

  factory Personel.fromJson(Map<String, dynamic> json) {
    return Personel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        salary: json["salary"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "surname": surname, "salary": salary};
  }
}
