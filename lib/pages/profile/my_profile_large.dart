import 'dart:async';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';

class MyProfileLargePage extends StatefulWidget {
  @override
  _MyProfileLargeState createState() => _MyProfileLargeState();
}

class _MyProfileLargeState extends State<MyProfileLargePage> {
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
                PageCap(text: "My Profile"),
                Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Image.network(user.imageUrl,
                                fit: BoxFit.cover,
                                height: 230,
                              )
                          ),
                          Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 10, top:10),
                                  child: CustomText(
                                    text: user.name,
                                    color: style.darkGrey,
                                    size: 20,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 0, top:10),
                                  child: CustomText(
                                    text: user.name,
                                    color: style.darkGrey,
                                    size: 16,
                                    weight: FontWeight.normal,
                                  ),
                                )
                              ]
                          )
                        ],
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 15, top: 10),
                          child: CustomText(
                            text: "My Services:",
                            color: style.darkGrey,
                            size: 18,
                            weight: FontWeight.bold,
                          )
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: myCards.map((item) => CvCardWidget(card: item)).toList()
                          )
                      )
                    ]
                )
              ],
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