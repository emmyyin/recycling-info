import 'package:flutter/material.dart';
import 'package:recycle_app/db_provider.dart';
import 'package:recycle_app/models/hazardous_material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', 
    home: Scaffold(
      body: FutureBuilder<List<HazardousMaterial>>(
        future: DBProvider.db.getAllHazardousMataerials(),
        builder: (BuildContext context, AsyncSnapshot<List<HazardousMaterial>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                HazardousMaterial item = snapshot.data[index];
                return ListTile(
                  title: Text(item.name),
                  leading: Text(item.id.toString()),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ),);
  }
}
