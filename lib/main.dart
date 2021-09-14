import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inno_tutor_flutter/constants/controllers.dart';
import 'package:inno_tutor_flutter/controllers/menu_controller.dart';
import 'package:inno_tutor_flutter/pages/my_profile/my_profile.dart';
import 'package:inno_tutor_flutter/pages/my_requests/my_requests.dart';
import 'package:inno_tutor_flutter/pages/my_schedule/my_schedule.dart';
import 'package:inno_tutor_flutter/pages/my_services/my_services.dart';
import 'package:inno_tutor_flutter/pages/my_students/my_students.dart';
import 'package:inno_tutor_flutter/widgets/large_screen.dart';

import 'layout.dart';

void main() {
  Get.put(MenuController());
  //Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Dash",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme
        ).apply(
          bodyColor: Colors.black
        ),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
        primaryColor: Colors.black,
      ),
      home: SiteLayout(page: MyProfile()),
      routes: {'My Services': (context) => SiteLayout(page: MyServices()),
        'My Profile': (context) => SiteLayout(page: MyProfile()),
        'My Students': (context) => SiteLayout(page: MyStudents()),
        'My Schedule': (context) => SiteLayout(page: MySchedule()),
        'My Requests': (context) => SiteLayout(page: MyRequests()),
      },
    );
  }
}