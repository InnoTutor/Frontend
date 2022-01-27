import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/request_models/request_model.dart';
import 'package:inno_tutor/models/request_models/student_request.dart';
import 'package:inno_tutor/models/request_models/tutor.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/search_card_dialog.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class SearchCard extends StatefulWidget {
  RequestModel user;

  SearchCard({this.user, Key key }) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  bool initFrame = true;
  int height = 100;
  bool buttonActive = false;

  final GlobalKey descriptionKey = GlobalKey();

  void updateStatus(){
    setState(() {
      buttonActive = !buttonActive;
    });
  }

  void initState() {
    widget.user.initializeCard();
    buttonActive = widget.user.requested;
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = descriptionKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  Container heading(){
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: CustomText(
        text : widget.user.name + " " + widget.user.surname + ", " + widget.user.subject, 
        weight: cardBoldWeight, 
        color: cardDarkerColor
      ),
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
            initialRating: (widget.user as Tutor).rating ?? 0,
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
          child: CustomText(
            text: (widget.user as Tutor).countVoted.toString() + " voted", 
            size: 12, 
            weight: 
            cardMediumWeight, 
            color: cardBrighterColor
          )
        ) 
      ]
    );
  }

  Container params(List<String> params, {bool type = false, bool format = false}){
    String param(){
      return (format ? "Format: " : type ? "Type: " : "");
    }

    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      child: 
        CustomText(
          text: param() + (params.length == 2 ? "both" : params[0]), 
          size: 12, 
          weight: cardMediumWeight, 
          color: cardBrighterColor
        )
    );
  }

  Container description(CustomText descriptionText){
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10, bottom: 10),
      alignment: Alignment.bottomLeft,
      child: descriptionText
    );
  }

  ElevatedButton actionButton(){
    return ElevatedButton(
      style: editableCardButtonStyle(buttonActive ? "red" : "white"),
      onPressed: () {
        if (!buttonActive){
          showDialog(context: context, 
            builder: (_) => SearchCardDialog(
              user: widget.user,
              updateStatus: updateStatus));
        } else {
          CardServices().deleteEnroll(widget.user.cardId);
          updateStatus();
        }
      },
      child: CustomText(
        text: buttonActive ? "Refuse" : "Request", 
        color: almostDarkGrey, 
        weight: FontWeight.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomText _descriptionText({bool setup = false}){
      return CustomText(
        text: widget.user.description,
        weight: FontWeight.normal,
        color: cardBrighterColor.withOpacity(setup ? 0 : 1),
        width: 660,
        key: descriptionKey
      );
    }

    CustomText descriptionTextSetup = _descriptionText(setup: true);
    CustomText descriptionText = _descriptionText();
    if (initFrame){
      return Wrap(children: [descriptionTextSetup]);
    }
    else{
      return Container(
        height: 100 + height.toDouble(),
        margin: EdgeInsets.only(right:5, left:5, top: 10),
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
                      heading(),
                      params(widget.user.sessionFormat, format: true),
                      params(widget.user.sessionType, type: true),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      (widget.user is Tutor) ? rating() : Wrap(),
                      Padding(
                        padding: widget.user is StudentRequest ? EdgeInsets.only(top: 10) : EdgeInsets.all(0),
                        child: actionButton(),
                      )
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
