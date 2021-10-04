import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
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
  bool data_fetched = false;
  @override
  initState() {
    super.initState();
    fetch_cards('');
  }

  Future<List<Card>> fetch_cards(String search) async {
    Services services = new Services();
    await services.getTutors();
    myCards = await services.getTutors();
    setState(() {});
    return myCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PageCap(text: "My Services"),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: myCards
                .map((item) => EditableCvCardWidget(card: item))
                .toList()),
      ),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: style.darkGreen),
          onPressed: () {
            _showDialog(context);
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

void _showDialog(BuildContext context) {

  Card newCard = Card(0, 0, 0, "", 0, "", [], [], false, 0);
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
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
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.topLeft,
                child: CustomDropDownButton(locations: _locations, card: newCard)
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: CheckBoxRow(card: newCard, color: style.darkGrey, themeColor: style.darkGrey,)
              ),
              Container(height: 10, child: Wrap()),
              Container(
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
                      style: TextStyle(fontFamily: 'SourceSans', color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Your description...",
                        hoverColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.white),
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
                  onPressed: () {
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

class CustomDropDownButton extends StatefulWidget {
  Card card;
  List<String> locations;
  String selectedLocation = "";
  CustomDropDownButton({ Key key, this.locations, this.selectedLocation, this.card}) : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: style.grey,
        borderRadius:  BorderRadius.all(Radius.circular(10)),
      ),
      child: DropdownButton(
        itemHeight: kMinInteractiveDimension,
        iconEnabledColor: style.lightGrey,
        dropdownColor: style.grey,
        focusColor: style.darkGrey,
        borderRadius: BorderRadius.circular(10),
        hint: CustomText(text: "Choose subject", color: Colors.white, weight: FontWeight.bold,),
        value: widget.selectedLocation,
        onChanged: (newValue) {
          setState(() {
            widget.card.subject = newValue;
            widget.selectedLocation = newValue;
          });
        },
        items: widget.locations.map((location) {
          return DropdownMenuItem(
            child: new CustomText(text: location, color: Colors.white, weight: FontWeight.bold,),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
