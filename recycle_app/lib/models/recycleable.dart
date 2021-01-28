import 'package:flutter/material.dart';

class Recycleable {
  String id = "";
  String type;
  List<String> names;
  List<String> hazardous = [];
  List<String> recyclePlaces = [];

  Recycleable({this.id, @required this.type, @required this.names, this.hazardous, this.recyclePlaces});
}
