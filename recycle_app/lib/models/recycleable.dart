import 'package:flutter/material.dart';

class Recycleable {
  String id;
  String type;
  String extra = "";
  List<String> names;
  List<String> hazardous = [];
  List<String> recyclePlaces = [];

  Recycleable(
      {@required this.id,
      @required this.type,
      this.extra,
      @required this.names,
      this.hazardous,
      this.recyclePlaces});
}
