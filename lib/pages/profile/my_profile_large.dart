import 'dart:async';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/services/auth.dart';
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
  var cards = List<Card>.generate(200, (index) => null);

  bool data_fetched = false;
  @override
  initState() {
    super.initState();
    fetch();
    fetch_cards('');
  }
  fetch()async{
    if(globals.user == null){
     globals.user= await AuthService().getUserData();

    }
    if(mounted){
      setState(() {

      });
    }
  }
  Future<List<Card>> fetch_cards(String search) async {
    Services services = new Services();
    globals.myCards = await services.getCvCards();
    if(mounted){
      setState(() {});
    }
    return globals.myCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                PageCap(text: "My Profile"),
                Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Image.network(
                            globals.user.imageUrl,
                            fit: BoxFit.cover,
                            height: 230,
                          )),
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: CustomText(
                            text: globals.user.name,
                            color: style.darkGrey,
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 0, top: 10),
                          child: CustomText(
                            text: globals.user.name,
                            color: style.darkGrey,
                            size: 16,
                            weight: FontWeight.normal,
                          ),
                        )
                      ])
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
                      )),
                  Container(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: globals.myCards.map((item) => CvCardWidget(card: item)).toList()
                          )
                      )
                ])
              ],
            );
  }
}