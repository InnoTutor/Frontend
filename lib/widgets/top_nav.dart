import 'dart:ui';
import 'package:flutter/cupertino.dart' hide Color;
import 'package:flutter/material.dart'hide Color;
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/pages/login_page.dart';
import 'package:inno_tutor/services/auth.dart';
import '../constants/style.dart' as style;
import '../helpers/responsiveness.dart'hide Color;
import 'package:inno_tutor/globals.dart' as globals hide Color;
import '../layout.dart';
import 'custom_text.dart'hide Color;
import 'logo.dart'hide Color;

class myAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function() notifyParent;
  myAppBar({Key key, @required this.notifyParent}) : super(key: key);
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
  @override
  _myAppBarState createState() => _myAppBarState();
}

class _myAppBarState extends State<myAppBar> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ResponsiveWidget.isSmallScreen(context)
          ? IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
              },
            )
          : null,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: style.darkGreen,
      title: Row(
        children: [
          !ResponsiveWidget.isSmallScreen(context)
              ? Logo(height: 30, leftPadding: 20, rightPadding: 0)
              : Container(),
          // Expanded(child: Container()),
          Container(
            width: 15,
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            child: ResponsiveWidget.isSmallScreen(context) || globals.user == null
                ? null
                : DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: _value,
                      items: <DropdownMenuItem<int>>[
                        new DropdownMenuItem(
                          child: !ResponsiveWidget.isSmallScreen(context)
                              ? Row(children: [
                                  CustomText(
                                    text: globals.user.name + " " + globals.user.surname,
                                    size: 18,
                                    color: Colors.black,
                                    weight: FontWeight.w600,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      child:CircleAvatar(
                                              radius: 18,
                                              backgroundColor: style.lightGreen,
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(globals.user.picture)))),
                                ])
                              : Container(),
                          value: 0,
                        ),
                        new DropdownMenuItem(
                          child: new Text('Logout'),
                          value: 1,
                          onTap: ()async{
                            await new AuthService().signOutGoogle();
                            setState(() {
                            _value=0;  
                            });
                            widget.notifyParent();

                          },
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                ),
          ),
          Container(
            width: 20,
          ),
          ResponsiveWidget.isSmallScreen(context)
              ? Logo(height: 30, leftPadding: 0, rightPadding: 0)
              : Container(),
        ],
      ),
      iconTheme: IconThemeData(color: style.lightGrey),
    );
  }

  refresh() {
    setState(() {});
  }
}