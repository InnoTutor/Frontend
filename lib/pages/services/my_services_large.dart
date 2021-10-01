import 'dart:async';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
import 'package:inno_tutor/ui_widgets/editable_cv_card_widget.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';

class MyServicesLargePage extends StatefulWidget {
  @override
  _MyServicesLargeState createState() => _MyServicesLargeState();
}

class _MyServicesLargeState extends State<MyServicesLargePage> {
  User user;
  bool data_fetched=false;

  Future <User> fetch() async {
   user=  await AuthService().getUserData();
   setState(() {

   });
   return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: fetch(), // stream data to listen for change
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData){
            return Column(
              children: [
                PageCap(text: "My Services"),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: myCards.map((item) => EditableCvCardWidget(card: item)).toList()
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: style.darkGreen
                    ),
                    onPressed: () {},
                    child: CustomText(text: "Add new Service Card", color: Colors.white,),
                  ),
                ),
              ]
            );

          }
          else {
            return Wrap();
            // Column(
            //     children:[
            //   SizedBox(
            //     child: CircularProgressIndicator(),
            //     width: 60,
            //     height: 60,
            //   ),
            //   Padding(
            //     padding: EdgeInsets.only(top: 16),
            //     child: Text('Awaiting result...'),
            //   )
            // ]
            // );
          }

        });
  }
}