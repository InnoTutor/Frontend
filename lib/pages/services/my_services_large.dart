import 'dart:async';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
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

  List myCards = [
    Card(0, 0, "Meth Analysis", 4.7, "Love doing Meth", ["offline", "online"], ["private"], false, 5),
    Card(1, 0, "DNP", 2.0, "Why not", ["offline"], ["private"], false, 6),
    Card(2, 0, "Descrete Meth", 5.0, "This is what i love the most", ["online"], ["public"], false, 7)
  ];


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