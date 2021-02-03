import 'package:flutter/material.dart';

import 'package:recycle_app/models/recycleable.dart';

/// Display all information about the given [recycleable]
class InfoPage extends StatelessWidget {
  final Recycleable recycleable;

  InfoPage(this.recycleable);

  Widget _displayNames() {
    List<String> names = recycleable.names;
    List<Widget> list = names
        .skip(1)
        .map((name) => new Text(
              name + " ",
              style: TextStyle(fontSize: 14),
            ))
        .toList();

    return Center(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                names[0],
                style: TextStyle(fontSize: 24),
              )),

          // Only display synonyms if there are any
          names.length > 1 ?
          Container(
            child: Text("Synonymer:", style: TextStyle(fontSize: 14)),
          ) : Container(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: list,
            ),
          )
        ],
      ),
    );
  }

  Widget _displayType() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "Kategori: " + recycleable.type,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _displayHazardous(List<String> hazardous) {}

  Widget _displayRecyclePlaces(List<String> places) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          children: [_displayNames(), _displayType()],
        ),
      ),
    );
  }
}
