import 'package:flutter/widgets.dart';
import 'package:inno_tutor_flutter/constants/controllers.dart';
import 'package:inno_tutor_flutter/routing/router.dart';
import 'package:inno_tutor_flutter/routing/routs.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: MyProfilePageRout,
  onGenerateRoute: generateRoute,
);