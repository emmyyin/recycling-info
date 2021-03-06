import 'package:flutter/material.dart';

import 'package:recycle_app/models/recycleable.dart';
import 'package:recycle_app/ui/pages/info_page.dart';

/// Display a dynamic list of all the recycleables
class DynamicList extends StatelessWidget {
  List<dynamic> list;

  DynamicList(this.list);

  Card _recycleableCard(BuildContext context, Recycleable r) {
    return Card(
      child: ListTile(
        title: Text(r.names[0]),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => InfoPage(r));
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _recycleableCard(context, list[index]);
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
