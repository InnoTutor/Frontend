import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/services/database.dart';

// ignore: must_be_immutable
class EditableCvCardWidget extends StatefulWidget{
  Card card;
  Function updateMyServices;
  EditableCvCardWidget({ Key key, this.card, this.updateMyServices}) : super(key: key);

  @override
  _EditableCvCardWidgetState createState() => _EditableCvCardWidgetState();
}

class _EditableCvCardWidgetState extends State<EditableCvCardWidget>{
  CustomText descriptionText;
  CustomText descriptionTextSetup;
  bool initFrame = true;
  bool heightUpdateNeeded = true;
  bool hidden = false;
  String reserveButtonText = "";
  final GlobalKey textKey = GlobalKey();

  void initState() {
    super.initState();
    hidden = widget.card.hidden;
    WidgetsBinding.instance
      .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      widget.card.height = params.size.height.toInt();
      initFrame = false;
    });
  }

  void updateData(){
    for(Card card in globals.myCards){
      if (card.cardId == widget.card.cardId){
        card = widget.card;
      }
    }
    print("done");
  }

  void manageEditButton(){
    if(mounted)
      setState(() {
      if (!widget.card.editable){
        widget.card.editable = true;
        widget.card.height = widget.card.height + 150;
        heightUpdateNeeded = false;
        widget.card.currentIcon = 0;
      } else {
        widget.card.editable = false;
        WidgetsBinding.instance
          .addPostFrameCallback((_) => updateHeight());
        widget.card.currentIcon = 1;
        widget.card.hidden = hidden;
        Services().edit(widget.card.cardId);
      }
      updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    descriptionTextSetup = CustomText(text : widget.card.description, weight: FontWeight.normal, color: almostDarkGrey.withOpacity(0), width: 660, key: textKey);
    descriptionText = CustomText(text : widget.card.description, weight: FontWeight.normal, color: almostDarkGrey, width: 660, key: textKey);
    reserveButtonText = widget.card.hidden ? "Unreserve" : "Reserve";
    if (initFrame){
      return Wrap(children: [descriptionTextSetup]);
    }
    else{
      if (heightUpdateNeeded){
        updateHeight();
      } 
      return Container(
        height: 68 + widget.card.height.toDouble(),
        margin: const EdgeInsets.only(right:10, left:10, top: 10),
        decoration: hidden ? commonHiddenCardDecoration : commonCardDecoration,
        child: Column(children: [       
          Row( //Card Heading
            children: [
              CardHeading(card: widget.card, manageEditButton: manageEditButton),
              VoteInformation(card: widget.card)
            ],
          ),

          CardDescription(card: widget.card, descriptionText: descriptionText,),
          widget.card.editable ? CheckBoxRow(card: widget.card, themeColor: almostDarkGrey, color: almostDarkGrey,) : Wrap(),
          widget.card.editable ?
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 15),
                child: ElevatedButton( //Delete Button
                  style: editableCardButtonStyle("delete"),
                  onPressed: ()async {
                    await Services().deleteCvCard(widget.card);
                    if(mounted)
                      setState(() {
                         widget.updateMyServices();
                    });
                  },
                  child: CustomText(text: "Delete", color: almostDarkGrey, weight: FontWeight.normal,),
                ),
              ),
              Container( //ReserveButton
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: ElevatedButton(
                  style: editableCardButtonStyle("reserve"),
                  onPressed: () {
                    if (!hidden){
                        setState(() {
                          hidden = true;
                          reserveButtonText = "Unreserve";
                      });
                    } else {
                        setState(() {
                          hidden = false;
                          reserveButtonText = "Reserve";
                      });
                    }
                  },
                  child: CustomText(text: reserveButtonText, color: almostDarkGrey, weight: FontWeight.normal,),
                ),
              ),
            ],
          ) : Wrap()
        ],
        )
      );
    }
  }
}

// ignore: must_be_immutable
class CardHeading extends StatelessWidget {
  Card card;
  Function manageEditButton;
  CardHeading({ Key key, this.card, this.manageEditButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        child: Row(
          children : [
            CustomText(text : card.subject, weight: FontWeight.w600, color: darkGrey),
            IconButton(
              padding: EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 0),
              icon: globals.icons[card.currentIcon],
              constraints: BoxConstraints(),
              onPressed: (){
                manageEditButton();
              },
            ),
          ]
        )
      )
    );
  }
}

// ignore: must_be_immutable
class CardDescription extends StatelessWidget {
  CustomText descriptionText;
  Card card;
  CardDescription({ Key key, this.card, this.descriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible( 
      child: Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      child: !card.editable ? 
        descriptionText :
        TextFormField (
          initialValue: descriptionText == null ? "" : descriptionText.text,
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          style: TextStyle(fontFamily: 'SourceSans', color: almostDarkGrey, fontWeight: FontWeight.w600),
          cursorColor: almostDarkGrey,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: almostDarkGrey)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: almostDarkGrey),
            ),
            fillColor: Colors.white.withOpacity(0.5),
            filled: true
          ),
          onChanged: (text) {
            card.description = text;
          },
        )
      )
    );
  }
}

// ignore: must_be_immutable
class VoteInformation extends StatefulWidget {
  Card card;
  VoteInformation({ Key key, this.card}) : super(key: key);

  @override
  _VoteInformationState createState() => _VoteInformationState();
}

class _VoteInformationState extends State<VoteInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right:10, top:10),
          child:AbsorbPointer(
            child: RatingBar(
              itemSize: 18,
              initialRating: widget.card.rating ?? 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Icon(Icons.star, color: almostDarkGrey),
                half: Icon(Icons.star_half, color: almostDarkGrey),
                empty: Icon(Icons.star_border, color: almostDarkGrey),
              ),
              ignoreGestures: true,
              onRatingUpdate: (rating) {
                print(rating);
              },
            )
          )
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: CustomText(text: "                 " + widget.card.countVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: almostDarkGrey,)
        )
      ],
    );
  }
}

