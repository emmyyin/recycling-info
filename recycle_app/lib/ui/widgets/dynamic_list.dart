import 'package:flutter/material.dart';

import 'package:recycle_app/models/recycleable.dart';

class DynamicList extends StatelessWidget {
  List<dynamic> list;

  DynamicList(this.list);

  Card _recycleableCard(Recycleable r) {
    return Card(
      child: ListTile(
        title: Text(r.names[0]),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _recycleableCard(list[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _myListView(context),
    );
  }
}
