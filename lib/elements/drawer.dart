
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override

  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  List<String> names = ['My Profile','My Services','My Students','My Schedule', 'My Requests'];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children:[
          ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(33, 97, 110, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Name Surname'),
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (context,index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.list),
                      title: Text(names[index]),
                      onTap: () {
                        Navigator.pushNamed(context, names[index]);
                      },
                    ),
                  );
                }),

        ],
      ),]

    ),);

  }

}