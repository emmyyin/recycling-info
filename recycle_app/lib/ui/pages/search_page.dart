import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchEdit = new TextEditingController();
  bool _isSearch = true;
  String _searchText = "";

  List<String> _recycleableItems;
  List<String> _searchedItems;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
