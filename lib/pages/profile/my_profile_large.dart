import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class MyProfileLargePage extends StatefulWidget {
  @override
  _MyProfileLargeState createState() => _MyProfileLargeState();
}

class _MyProfileLargeState extends State<MyProfileLargePage> {
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  Future<List<Card>> fetch_cards(String search) async {
    if(globals.myCards == null) {

      globals.myCards = await new Services().getMyCvCards();
      print(globals.myCards);
      if (mounted) {
        setState(() {
        });
      }
    }
    return globals.myCards;
  }

  Container profilePicture = Container(
    child: Image.network(
      globals.user.picture,
      fit: BoxFit.cover,
      height: 230,
    )
  );

  Container userName = Container(
    child: CustomText(
      text: globals.user.name,
      color: style.darkGrey,
      size: 20,
      weight: FontWeight.w400,
    ),
  );

  Container userDescription = Container(
    child: CustomText(
      text: globals.user.name,
      color: style.darkGrey,
      size: 16,
      weight: FontWeight.w300,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageCap(text: "My Profile"),
        Column(children: [
          Container( //ProfilePic + Name + Description
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profilePicture,
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [userName, userDescription]
                  ),
                )
              ],
            ),
          ),
          Container( //Services Text
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 15, top: 10),
            child: CustomText(
              text: "Services:",
              color: style.darkGrey,
              size: 18,
              weight: FontWeight.w400
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: globals.myCards != null ? Column(
              mainAxisSize: MainAxisSize.min,
              children: 
              globals.myCards.map((item) => CvCardWidget(card: item)).toList()
            ) : 
            Container(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                backgroundColor: style.grey,
                valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}