import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class SearchTutorCardWidget extends StatefulWidget{
  Tutor tutor;
  SearchTutorCardWidget({ Key key, this.tutor}) : super(key: key);

  @override
  _SearchTutorCardWidgetState createState() => _SearchTutorCardWidgetState();
}

class _SearchTutorCardWidgetState extends State<SearchTutorCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  final GlobalKey textKey = GlobalKey();
  int height = 100;

  void initState() {
    widget.tutor.initializeCard();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      print("Not editable update" + widget.tutor.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomText descriptionTextSetup = CustomText(text : widget.tutor.description, weight: FontWeight.normal, color: cardBrighterColor.withOpacity(0), width: 660, key: textKey);
    CustomText descriptionText = CustomText(text : widget.tutor.description, weight: FontWeight.normal, color: cardBrighterColor, width: 660, key: textKey);
    if (initFrame){
      return Wrap(children: [descriptionTextSetup]);
    }
    else{
      return Container(
          child: InkWell(
            child: Container(
              height: 100+height.toDouble(),
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
                      child: CustomText(text : widget.tutor.tutorName + " " + widget.tutor.tutorSurname + ", " + widget.tutor.subject, weight: cardBoldWeight, color: cardDarkerColor),
                      )
                    ),
                    Column(children: [
                      Container(
                        padding: EdgeInsets.only(right:10, top:10),
                        child: RatingBar(
                          itemSize: 18,
                          initialRating: widget.tutor.rating ?? 0,
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
                        //padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(text: "                 " + widget.tutor.countVoted.toString() + " voted", size: 12, weight: cardMediumWeight, color: cardBrighterColor)
                      ),  
                    ],)
                  ],),
                  // Expanded(
                  //   child: Container(height: 0,),
                  // ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: widget.tutor.sessionFormat.length == 2 ? 
                      CustomText(text: "Format: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
                      CustomText(text: "Format: " + widget.tutor.sessionFormat[0], size: 12, weight: cardMediumWeight, color: cardBrighterColor),
                    )
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: widget.tutor.sessionType.length == 2 ? 
                      CustomText(text: "Type: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
                      CustomText(text: "Type: " + widget.tutor.sessionType[0], size: 12, weight: cardMediumWeight, color: cardBrighterColor)
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      alignment: Alignment.bottomLeft,
                      child: descriptionText
                    )
                  )
                ],
              ),
              )
            ),
            // onTap: () {
            
            // },
            // onHover: (isHovering){
            //   setState(() {
            //     if (isHovering){
            //       color = style.grey;
            //     } else{
            //       color = style.darkGreen;
            //     }
            //   });
            // }
          )
      );
    }
  }
}