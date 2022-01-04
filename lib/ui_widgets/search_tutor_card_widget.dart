import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/check_box_row.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_tutor/widgets/page_cap.dart';
import '../constants/style.dart' as style;

// ignore: must_be_immutable
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
  bool requested = false;

  void initState() {
    widget.tutor.initializeCard();
    requested = widget.tutor.requested;
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

  void updateStatus(){
    setState(() {
      requested = !requested;
    });
  }

  Container tutorHeading(){
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: CustomText(text : widget.tutor.tutorName + " " + widget.tutor.tutorSurname + ", " + widget.tutor.subject, weight: cardBoldWeight, color: cardDarkerColor),
    );
  }

  Column rating(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(top:10),
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
          child: CustomText(text: widget.tutor.countVoted.toString() + " voted", size: 12, weight: cardMediumWeight, color: cardBrighterColor)
        ) 
      ]
    );
  }

  Container format(){
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      child: widget.tutor.sessionFormat.length == 2 ? 
      CustomText(text: "Format: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
      CustomText(text: "Format: " + widget.tutor.sessionFormat[0], size: 12, weight: cardMediumWeight, color: cardBrighterColor),
    );
  }

  Container type(){
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      child: widget.tutor.sessionType.length == 2 ? 
      CustomText(text: "Type: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
      CustomText(text: "Type: " + widget.tutor.sessionType[0], size: 12, weight: cardMediumWeight, color: cardBrighterColor)
    );
  }

  Container description(CustomText descriptionText){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, bottom: 10),
      alignment: Alignment.bottomLeft,
      child: descriptionText
    );
  }

  ElevatedButton enrollButton(){
    return ElevatedButton(
      style: editableCardButtonStyle(requested ? "red" : "white"),
      onPressed: () {
        if (!requested){
          showDialog(context: context, 
            builder: (_) => CustomDialog(
              cardId: widget.tutor.cardId, 
              sessionFormat: widget.tutor.sessionFormat, 
              sessionType: widget.tutor.sessionType,
              updateStatus: updateStatus));
        } else {
          CardServices().deleteEnroll(widget.tutor.cardId);
          updateStatus();
        }
      },
      child: CustomText(text: requested ? "Refuse" : "Request", color: almostDarkGrey, weight: FontWeight.normal,),
    );
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
        height: 100+height.toDouble(),
        margin: const EdgeInsets.only(right:5, left:5, top: 10),
        decoration: commonCardDecoration,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tutorHeading(),
                      format(),
                      type(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      rating(),
                      enrollButton()
                    ],
                  ),
                ),
              ],
            ),
            description(descriptionText)
          ],
        ),
      );
    }
  }
}

class CustomDialog extends StatefulWidget {
  int cardId;
  List<String> sessionFormat;
  List<String> sessionType;
  Function updateStatus;
  CustomDialog({this.cardId, this.sessionFormat, this.sessionType, this.updateStatus, Key key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Enrollment enrollment = Enrollment(-1, "", [], []);
  Card newCard = Card(0, 0, "", 0, "", [], [], false, 0);
  String warning = "";

  void updateDialog(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    enrollment.cardId = widget.cardId;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: style.lightGrey,
      content: SizedBox(
        height: 310,
        child: Column(
          children: [
            Container(
              width: 610,
              child: PageCap(text: "Confirm your request", padding: 0, color: style.grey)
            ),
            Container(
              width: 610,
              padding: EdgeInsets.only(top: 10),
              child: CheckBoxRow(card: newCard, color: style.darkGrey, themeColor: style.darkGrey,
                availableSessionFormats: widget.sessionFormat, availableSessionTypes: widget.sessionType,
                updateDialog: updateDialog,)
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
                    style: TextStyle(fontFamily: 'SourceSans', color: almostDarkGrey, fontWeight: FontWeight.w600),
                    cursorColor: almostDarkGrey,
                      decoration: InputDecoration(
                      hintText: "Add comments...",
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
                      newCard.description = text;
                    },
                  )
                )
            ),
            Container(
              padding: EdgeInsets.only(top:10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: style.darkGreen),
                onPressed: widget.sessionFormat.length == 1 && widget.sessionType.length == 1 ||
                  !(newCard.sessionFormat.isEmpty || newCard.sessionType.isEmpty) ? () async{
                  enrollment.description = newCard.description;
                  enrollment.sessionFormat = newCard.sessionFormat;
                  enrollment.sessionType = newCard.sessionType;
                  CardServices().createEnroll(enrollment);                  
                  widget.updateStatus();
                  Navigator.of(context).pop();
                } : null,
                child: CustomText(
                  text: "Send Request",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
