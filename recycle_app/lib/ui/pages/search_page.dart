import 'package:flutter/material.dart';
import 'package:recycle_app/models/recycleable.dart';

import 'package:recycle_app/resources/database.dart';
import 'package:recycle_app/ui/widgets/dynamic_list.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textController = TextEditingController();
  DBProvider _db = DBProvider();
  List<dynamic> _list = [];
  List<dynamic> _searchList = [];

  @override
  void initState() {
    _getList().then((list) {
      setState(() {
        _list = list;
        _searchList = list;
      });
    });
  }

  Future<List<dynamic>> _getList() async {
    return await _db.getRecycleables();
  }

  void _onItemChanged(String value) {
    setState(() {
      List<dynamic> newList = [];
      for (Recycleable r in _list) {
        for (String name in r.names) {
          if (name.toLowerCase().contains(value.toLowerCase())) {
            newList.add(r);
            break;
          }
        }
      }
      _searchList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16.0),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'Sök'),
            textAlign: TextAlign.center,
            onChanged: _onItemChanged,
          ),
        ),
        _list.isEmpty
            ? CircularProgressIndicator()
            : Expanded(child: DynamicList(_searchList))
      ],
    ));
  }
}
