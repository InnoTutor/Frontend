import 'package:flutter/material.dart';
import 'package:inno_tutor_flutter/helpers/responsiveness.dart';
import 'package:inno_tutor_flutter/widgets/large_screen.dart';
import 'package:inno_tutor_flutter/widgets/side_menu.dart';
import 'package:inno_tutor_flutter/widgets/small_screen.dart';
import 'package:inno_tutor_flutter/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: TopNavigationBar(context, scaffoldKey),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        mediumScreen: LargeScreen(),
        smallScreen: SmallScreen(),
        ),
      drawer : ResponsiveWidget.isSmallScreen(context) ? Drawer(child: SideMenu()) : null
    );
  }
}