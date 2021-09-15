import 'package:flutter/material.dart';
import 'package:inno_tutor/elements/drawer.dart';
import 'package:inno_tutor/helpers/responsiveness.dart';
import 'package:inno_tutor/widgets/large_screen.dart';
import 'package:inno_tutor/widgets/small_screen.dart';
import 'package:inno_tutor/widgets/top_nav.dart';
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
      drawer : ResponsiveWidget.isSmallScreen(context) ? 
      // Drawer(child: SideMenu()) 
      AppDrawer()
      :
      null
    );
  }
}