import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
import 'package:inno_tutor/ui_widgets/editable_cv_card_widget.dart';
import 'package:inno_tutor/widgets/custom_dropdown_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class MyServicesLargePage extends StatefulWidget {
  @override
  _MyServicesLargeState createState() => _MyServicesLargeState();
}

class _MyServicesLargeState extends State<MyServicesLargePage> {
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  Future<List<Card>> fetch_cards(String search) async {
    if(globals.myCards == null) {
      globals.myCards = await new Services().getMyCvCards();
      if (mounted) {
        setState(() {
        });
      }
    }
    return globals.myCards;
  }

  void update(){
    if(mounted)
      setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: "My Services"),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: globals.myCards!=null ? Column(
            mainAxisSize: MainAxisSize.min,
            children: globals.myCards
                .map((item) => EditableCvCardWidget(card: item, updateMyServices: update))
                .toList()) :
                Container(
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                      backgroundColor: style.grey,
                      valueColor: new AlwaysStoppedAnimation<Color>(style.lightGrey),
                    ),
                ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: style.darkGreen),
          onPressed: ()async {
            List<String>subjects = await Services().getSubjects();

            _showDialog(context, update,subjects);
          },
          child: CustomText(
            text: "Add new Service Card",
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}

void _showDialog(BuildContext context, Function update, List<String> subjects) async{

  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  newCard.setEditable(false);
  String _selectedLocation; // Option 2
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: style.lightGrey,
        content: SizedBox(
          height: 370,
          child: Column(
            children: [
              Container(
                width: 610,
                child: PageCap(text: "Add new CV Card", padding: 0, color: style.grey)
              ),
              Container(
                width: 610,
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                child: CustomDropDownButton(locations: subjects, card: newCard)
              ),
              Container(
                width: 610,
                padding: EdgeInsets.only(top: 10),
                child: CheckBoxRow(card: newCard, color: style.darkGrey, themeColor: style.darkGrey,)
              ),
              Container(height: 10, child: Wrap()),
              Container(
                width: 600,
                height: 150,
                decoration: BoxDecoration(
                  color: style.grey,
                  borderRadius:  BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: 
                    TextFormField (
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      style: TextStyle(fontFamily: 'SourceSans', color: style.darkGrey, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: "Your description...",
                        hoverColor: Colors.white,
                        hintStyle: TextStyle(color: style.darkGrey, fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey
                      ),
                      onChanged: (text) {
                        newCard.description = text;
                      },
                    )
                  )
              ),
              Container(
                padding: EdgeInsets.only(top:10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: style.darkGreen),
                  onPressed: () async{
                    newCard = await Services().create(newCard);
                    update();
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: "Add new Service Card",
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      )
  );
}

