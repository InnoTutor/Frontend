import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class EditableCvCardWidget extends StatefulWidget{
  Card card;
  EditableCvCardWidget({ Key key, this.card}) : super(key: key);

  @override
  _EditableCvCardWidgetState createState() => _EditableCvCardWidgetState();
}

class _EditableCvCardWidgetState extends State<EditableCvCardWidget>{
  CustomText descriptionText;
  bool initFrame = true;
  bool heightUpdateNeeded = true;
  String reserveButtonText = "";
  final GlobalKey textKey = GlobalKey();

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    setState(() {
      widget.card.height = params.size.height.toInt();
      initFrame = false;
    });
  }

  void updateData(){
    for(Card card in myCards){
      if (card.cardId == widget.card.cardId){
        card = widget.card;
      }
    }
  }

  void manageEditButton(){
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    descriptionText = CustomText(text : widget.card.description, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    reserveButtonText = widget.card.isReserved ? "Unreserve" : "Reserve";
    if (initFrame){
      print("rendering");
      return Wrap(children: [descriptionText]);
    }
    else{
      if (heightUpdateNeeded){
        updateHeight();
      } 
      return Container( 
          child: InkWell(
            child: Container(
              height: 68+widget.card.height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color : widget.card.isReserved ? style.darkGrey : style.darkGreen,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                child: 
                Column(children: [       
                  Row(
                    children: [
                      CardHeading(card: widget.card, manageEditButton: manageEditButton),
                      VoteInformation(card: widget.card)
                    ],
                  ),
                  CardDescription(card: widget.card, descriptionText: descriptionText,),
                  widget.card.editable ? 
                    CheckBoxRow(card: widget.card, themeColor: Colors.white,) : Wrap(),
                  widget.card.editable ?
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: style.pink
                          ),
                          onPressed: () {
                            setState(() {
                              myCards.remove(widget.card);
                            });
                          },
                          child: CustomText(text: "Delete", color: style.darkGrey, weight: FontWeight.bold,),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: () {
                            if (!widget.card.isReserved){
                              widget.card.isReserved = true;
                              setState(() {
                                reserveButtonText = "Unreserve";
                              });
                            } else {
                              widget.card.isReserved = false;
                              setState(() {
                                reserveButtonText = "Reserve";
                              });
                            }
                          },
                          child: CustomText(text: reserveButtonText, color: style.darkGrey, weight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ) : Wrap()
                ],
              ),
              )
            ),
          )
      );
    }
  }
}

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
            CustomText(text : card.subject, weight: FontWeight.bold, color: Colors.white),
            IconButton(
              padding: EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 0),
              icon: icons[card.currentIcon],
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
          style: TextStyle(fontFamily: 'SourceSans', color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            border: const OutlineInputBorder(),
            fillColor: Colors.grey
          ),
          onChanged: (text) {
            card.description = text;
          },
        )
      )
    );
  }
}

class VoteInformation extends StatelessWidget {
  Card card;
  VoteInformation({ Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right:10, top:10),
          child:AbsorbPointer(
            // child: RatingBar(
            //   itemSize: 18,
            //   initialRating: widget.card.rating,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   ratingWidget: RatingWidget(
            //     full: Icon(Icons.star, color: Colors.white),
            //     half: Icon(Icons.star_half, color: Colors.white),
            //     empty: Icon(Icons.star_border, color: Colors.white),
            //   ),
            //   ignoreGestures: true,
            //   onRatingUpdate: (rating) {
            //     print(rating);
            //   },
            // )
            child: Wrap(),
          )
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: CustomText(text: "                 " + card.countVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: Colors.white,)
        )
      ],
    );
  }
}