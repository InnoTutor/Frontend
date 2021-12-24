import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class CvCardWidget extends StatefulWidget{
  Card card;
  CvCardWidget({ Key key, this.card}) : super(key: key);

  @override
  _CvCardWidgetState createState() => _CvCardWidgetState();
}

class _CvCardWidgetState extends State<CvCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  final GlobalKey textKey = GlobalKey();
  int height = 100;

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      print("Not editable update" + widget.card.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomText descriptionTextSetup = CustomText(text : widget.card.description, color: cardBrighterColor.withOpacity(0), width: 660, key: textKey, weight: cardMediumWeight);
    CustomText descriptionText = CustomText(text : widget.card.description, color: cardBrighterColor, width: 660, key: textKey, weight: cardMediumWeight);
    if (initFrame){
      return Wrap(children: [descriptionTextSetup]);
    }
    else{
      return !widget.card.hidden ? Container(
          child: Container(
            height: 68+height.toDouble(),
            margin: const EdgeInsets.only(right:5, left:5, top: 10),
            decoration: commonCardDecoration,
            child: Container(
              child: 
              Column(children: [
                
                Row(children: [
                  Flexible(
                    child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: CustomText(text : widget.card.subject, weight: cardBoldWeight, color: cardDarkerColor),
                    )
                  ),
                  Column(children: [
                    Container(
                      padding: EdgeInsets.only(right:10, top:10),
                      child: RatingBar(
                        itemSize: 18,
                        initialRating: widget.card.rating ?? 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: cardBrighterColor),
                          half: Icon(Icons.star_half, color: cardBrighterColor),
                          empty: Icon(Icons.star_border, color: cardBrighterColor),
                        ),
                        ignoreGestures: true,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: "                 " + widget.card.countVoted.toString() + " voted", size: 12, color: cardBrighterColor, weight: cardMediumWeight,)
                    )
                  ],)
                ],),
                Flexible(
                  child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: descriptionText
                  )
                )
              ],
            ),
            )
          )
      ) : Wrap();
    }
  }
}