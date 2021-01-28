class Recycleable {
  String id;
  String type;
  List<String> names;
  List<String> hazardous;
  List<String> recyclePlaces;

  Recycleable({this.id, this.type, this.names, this.hazardous, this.recyclePlaces});

  Map<String, dynamic> toMap() {
    return {'id': id, 'type': type, 'names': names, 'hazardous': hazardous, 'recycle_places': recyclePlaces};
  }
}
