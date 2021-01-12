class RecyclePlace {
  int id;
  String name;

  RecyclePlace({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
