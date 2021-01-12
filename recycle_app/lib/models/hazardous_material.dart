class HazardousMaterial {
  int id;
  String name;

  HazardousMaterial({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
