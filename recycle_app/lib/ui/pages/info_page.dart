import 'package:flutter/material.dart';

import 'package:recycle_app/models/recycleable.dart';

/// Display all information about the given [recycleable]
class InfoPage extends StatelessWidget {
  final Recycleable recycleable;

  InfoPage(this.recycleable);

  Widget _displayNames() {
    List<String> names = recycleable.names;
    List<Widget> list = names.skip(1).map((name) => new Text(name)).toList();

    return Center(
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                names[0],
                style: TextStyle(fontSize: 24),
              )),

          // Only display synonyms if there are any
          names.length > 1
              ? Container(
                  child: Text("Synonymer:"),
                )
              : Container(),
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
      padding: EdgeInsets.all(20),
      child: Text(
        "Sorteras som: " + recycleable.type,
      ),
    );
  }

  Widget _displayHazardous() {
    List<String> materials = recycleable.hazardous;
    List<Widget> list =
        materials.map((material) => new Text(material)).toList();

    return Center(
      child: Column(
        children: [
          // Only display hazardous materials if there are any
          list.length > 1
              ? Container(
                  child: Text("Varningsklasser:"),
                )
              : Container(),
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

  // TODO: Implement this
  Widget _displayRecyclePlaces() {
    List<String> places = recycleable.recyclePlaces;
    List<Widget> list =
        places.map((place) => new Text(place)).toList();

    return Center(
      child: Column(
        children: [
          list.length > 1
              ? Container(
                  child: Text("Lämnas:"),
                )
              : Container(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(color: Colors.white,),
      ),
      body: Container(
        child: Column(
          children: [_displayNames(), _displayType(), _displayHazardous(), _displayRecyclePlaces()],
        ),
      ),
    );
  }
}
