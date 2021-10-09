import 'package:flutter/material.dart' hide Card;
import 'package:get/get.dart';
import 'package:inno_tutor/constants/controllers.dart';
import 'package:inno_tutor/elements/routes.dart';
import 'package:inno_tutor/elements/side_menu_item.dart';
import 'package:inno_tutor/globals.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/pages/need_help/need_help.dart';
import 'package:inno_tutor/pages/profile/my_profile.dart';
import 'package:inno_tutor/pages/requests/my_requests.dart';
import 'package:inno_tutor/pages/schedules/my_schedules.dart';
import 'package:inno_tutor/pages/services/my_serviecs.dart';
import 'package:inno_tutor/pages/students/my_students.dart';
import 'package:inno_tutor/pages/tutros/my_tutors.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/logo.dart';
import '../../constants/style.dart' as style;
import 'package:inno_tutor/globals.dart' as globals;

class SideMenu extends StatefulWidget {
  final VoidCallback onPageSelected;
  final Function(int) onPageChanged;
  Function updPage;
  SideMenu({this.onPageSelected, this.onPageChanged, this.updPage});

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<String> title = ['My Profile','My Services','My Students','My Tutors', 'My Schedule', 'My Requests'];
    List<Widget> names = [
      MyProfile(),
      MyServices(),
      MyStudents(),
      MyTutors(),
      MySchedules(),
      MyRequests(),
    ];    String route='';

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return globals.user != null ? ClipRRect(
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: style.lightGreen,
                title: Row(
                  children: [
                    Logo(
                      path: 'assets/icons/dark_logo.png',
                      height: 30,
                      leftPadding: 0,
                      rightPadding: 0
                    ),
                    Padding(padding: EdgeInsets.only(right: 5),
                    ),
                  ],
                )
              ),
              Divider(color: style.grey.withOpacity(0.1), height: 10,),
              Container(
                height: 100,
                color: style.lightGrey,
                child: (
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:NetworkImage(globals.user.picture)
                  )
                      ),
                      CustomText(
                        text: globals.user.name,
                        color: style.almostDarkGrey,
                        size: 18,
                        weight: FontWeight.w800 
                      )
                    ]
                  )
                ),
              )
            ]
          ),
          Divider(color: style.grey.withOpacity(0.1), height: 10,),
          Column(mainAxisSize: MainAxisSize.min,
            children: sideMenuItems.map((itemName) => SideMenuItem(
              itemName: itemName,
              onTap: (){
                for (Card card in myCards){
                  card.setEditable(false);
                }
                if (!menuController.isActive(itemName)){
                  menuController.changeActiveItemTo(itemName);
                  widget.updPage(names[title.indexOf(itemName)]);
                  if (ResponsiveWidget.isSmallScreen(context))
                    Get.back();
                }
              }
            )).toList()
          )
        ],
      ),
    ) : Wrap();
  }
}