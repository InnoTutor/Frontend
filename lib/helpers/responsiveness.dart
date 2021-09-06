import 'package:flutter/cupertino.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 945;
const int smallScreenSize = 360;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;
  final Widget customScreen;
  
  const ResponsiveWidget({ 
    Key key,
    this.largeScreen,
    this.mediumScreen, 
    this.smallScreen,
    this.customScreen}) : super(key: key);
  
  static bool isSmallScreen(BuildContext context) =>
  MediaQuery.of(context).size.width < mediumScreenSize;

  static bool isMediumScreen(BuildContext context) =>
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width < largeScreenSize;

  static bool isLargeScreen(BuildContext context) =>
  MediaQuery.of(context).size.width >= largeScreenSize;

  static bool isCustomSize(BuildContext context) =>
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width <= customScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      double _width = constraints.maxWidth;
      if (_width >= largeScreenSize) return largeScreen;
      else if (_width < largeScreenSize && _width >= mediumScreenSize) return mediumScreen ?? largeScreen;
      else return smallScreen ?? largeScreenSize;
    });
  }
}