import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/pages/requests/my_requests.dart';
import 'package:inno_tutor/pages/schedules/my_schedules.dart';
import 'package:inno_tutor/pages/services/my_serviecs.dart';
import 'package:inno_tutor/pages/students/my_students.dart';
//import 'package:inno_tutor_flutter/widgets/side_menu.dart';
class LargeScreen extends StatefulWidget {
  Widget page;
   void Function() onTap;
   LargeScreen({ Key key , this.onTap, this.page}) : super(key: key);

  @override
  _LargeScreenState createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  get lightGrey => null;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    List<String> title = ['My Profile','My Services','My Students','My Schedule', 'My Requests'];
    List<Widget> names = [
      MyProfile(),
      MyServices(),
      MyStudents(),
      MySchedules(),
      MyRequests()
    ];    String route='';
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: style.lightGrey,
              child: Container(
              width: 700,
              color: style.lightGrey,
              alignment: Alignment.topRight,
              child: Container(
                child: Container(
                  width: 230,
                  height: ResponsiveWidget.isCustomSize(context) ? 520 : 300,
                  margin: const EdgeInsets.only(right:5, left:10, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 5,
                        blurRadius: 7,
                      )
                    ]
                  ),
                  child: Drawer(

                    child: Stack(
                        children:[
                          ListView(
                            // Important: Remove any padding from the ListView.
                            padding: EdgeInsets.zero,
                            children: <Widget>[
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
                                          setState(() {
                                            widget.page = names[index];
                                          });
                                          // Navigator.pushNamed(context, names[index],arguments: {'route':route});
                                        },
                                      ),
                                    );
                                  }),

                            ],
                          ),]

                    ),),
                )
              )
            )
            )
          ),
          SizedBox(
            child: Container(
              width: 700,
              color: style.lightGrey,
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Container(
                  height: 600,
                  margin: const EdgeInsets.only(right:5, left:5, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        spreadRadius: 5,
                        blurRadius: 7,
                      )
                    ]
                  ),
                  child: widget.page,
                )
              )
            )
          ),
          Expanded(
            child: Container(
              color: style.lightGrey
            )
          ),
        ],
      )
    );
  }
}