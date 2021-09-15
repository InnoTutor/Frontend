
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override

  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  List<String> title = ['My Profile','My Services','My Students','My Schedule', 'My Requests'];
  List<String> names = ['/profile','/services','/students','/schedule', '/requests'];
  String route='';
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Stack(
        children:[
          ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(

            //   decoration: BoxDecoration(
            //     color: Color.fromRGBO(33, 97, 110, 1),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text('Name Surname'),
            //   ),
            // ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (context,index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.list),
                      title: Text(title[index]),
                      onTap: () {
                        print((ModalRoute.of(context).settings.name as String) + ' drawerrr');
                        var arguments = ModalRoute.of(context).settings.arguments;
                        String route = ModalRoute.of(context).settings.name as String;
                        if (arguments != null) {
                          arguments = arguments as Map;
                          route = route + (arguments as Map)["route"].toString();
                          print((arguments as Map)["route"].toString() + '   drawerrr');
                        }
                        Navigator.pushNamed(context, names[index],arguments: {'route':route});
                        // .then((value) =>
                            // Scaffold.of(context).openEndDrawer()
                          // Navigator.pop(context)

                        // );

                      },
                    ),
                  );
                }),

        ],
      ),]

    ),);

  }

}