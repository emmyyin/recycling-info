import 'package:firebase_database/firebase_database.dart';
import 'package:recycle_app/models/recycleable.dart';

class DBProvider {
  static DBProvider _instance;
  static DatabaseReference _databaseReference;

  DBProvider._internal() {
    _instance = this;
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  factory DBProvider() => _instance ?? DBProvider._internal();

  /// Creates Recycleable from data [item]
  Recycleable _recycableFromData(String id, Map<dynamic, dynamic> item) {
    List<String> names = [];
    List<String> hazardous = [];
    List<String> places = [];
    String extra = "";
    String type = item["type"];

    item["names"].values.forEach((value) => names.add(value["name"]));
    item["recycle_places"]
        .values
        .forEach((value) => places.add(value["place"]));
    if (item.containsKey("hazardous")) {
      item["hazardous"]
          .values
          .forEach((value) => hazardous.add(value["material"]));
    }
    if (item.containsKey("extra")) {
      extra = item["extra"];
    }

    return Recycleable(
        id: id,
        type: type,
        extra: extra,
        names: names,
        hazardous: hazardous,
        recyclePlaces: places);
  }

  /// Returns Recycleables retrieved from database
  Future<List<Recycleable>> getRecycleables() async {
    List<Recycleable> recycleables = [];
    await _databaseReference
        .child("recycleables")
        .once()
        .then((DataSnapshot snapshot) {
      snapshot.value.forEach((key, childSnapshot) {
        recycleables.add(_recycableFromData(key, childSnapshot));
      });
    });

    return recycleables;
  }
}
