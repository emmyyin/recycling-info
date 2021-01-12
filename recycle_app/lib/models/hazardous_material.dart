class Hazardous {
  int id;
  String name;

  Hazardous({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
