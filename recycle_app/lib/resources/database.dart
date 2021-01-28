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

  /// Create Recycleable from data [item] from database 
  Recycleable _recycableFromData(Map<dynamic, dynamic> item) {
    List<String> names = [];
    List<String> hazardous = [];
    List<String> places = [];
    String type = item["type"];

    item["names"].values.forEach((value) => names.add(value["name"]));
    if (item.containsKey("hazardous")) {
      item["hazardous"]
          .values
          .forEach((value) => hazardous.add(value["material"]));
    }

    return Recycleable(
        type: type, names: names, hazardous: hazardous, recyclePlaces: places);
  }

  /// Get list of Recycleables retrieved from database
  Future<List<Recycleable>> getRecycleables() async {
    List<Recycleable> recycleables = [];
    await _databaseReference
        .child("recycleables")
        .once()
        .then((DataSnapshot snapshot) {
      // print('Data : ${snapshot.value}');
      snapshot.value.forEach(
          (childSnapshot) => recycleables.add(_recycableFromData(childSnapshot)));
    });

    return recycleables;
  }
}
