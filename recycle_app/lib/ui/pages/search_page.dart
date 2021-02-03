import 'package:flutter/material.dart';

import 'package:recycle_app/resources/database.dart';
import 'package:recycle_app/ui/widgets/dynamic_list.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DBProvider _db = DBProvider();
  List<dynamic> _list;

  @override
  void initState() {
    getList().then((list) {
            setState(() {
                _list = list;
            });
        });
    getList();
  }

  Future<List<dynamic>> getList() async {
    return await _db.getRecycleables();
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty){
      return CircularProgressIndicator();
    }

    return Container(
      child: DynamicList(_list),
    );
  }
}
