import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/constants/controllers.dart';
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/large_screen.dart';
import 'package:inno_tutor_flutter/widgets/side_menu.dart';
import 'package:inno_tutor_flutter/widgets/small_screen.dart';
import 'package:inno_tutor_flutter/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget{
  final Widget page;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key key, this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.name);
    return Scaffold(
      key: scaffoldKey,
      appBar: TopNavigationBar(context, scaffoldKey),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(page: page),
        mediumScreen: LargeScreen(page: page),
        smallScreen: SmallScreen(page: page),
        ),
      drawer : ResponsiveWidget.isSmallScreen(context) ? Drawer(child: SideMenu()) : null
    );
  }
}