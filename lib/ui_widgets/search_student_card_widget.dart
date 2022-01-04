import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../constants/style.dart' as style;

// ignore: must_be_immutable
class SearchStudentCardWidget extends StatefulWidget{
  StudentRequest studentRequest;
  SearchStudentCardWidget({ Key key, this.studentRequest}) : super(key: key);

  @override
  _SearchStudentCardWidgetState createState() => _SearchStudentCardWidgetState();
}

class _SearchStudentCardWidgetState extends State<SearchStudentCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  final GlobalKey textKey = GlobalKey();
  int height = 100;
  

  void initState() {
    widget.studentRequest.initializeCard();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      print("Not editable update" + widget.studentRequest.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    CustomText descriptionTextSetup = CustomText(text : widget.studentRequest.description, weight: cardMediumWeight, color: cardBrighterColor.withOpacity(0), width: 660, key: textKey);
    CustomText descriptionText = CustomText(text : widget.studentRequest.description, weight: cardMediumWeight, color: cardBrighterColor, width: 660, key: textKey);
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
                      child: CustomText(text : widget.studentRequest.studentName + " " + widget.studentRequest.studentSurname + ", " + widget.studentRequest.subject, weight: cardBoldWeight, color: cardDarkerColor),
                      )
                    ),
                  ],),
                  // Expanded(
                  //   child: Container(height: 0,),
                  // ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: widget.studentRequest.sessionFormat.length == 2 ? 
                      CustomText(text: "Format: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
                      CustomText(text: "Format: " + (widget.studentRequest.sessionFormat.length == 1 ? widget.studentRequest.sessionFormat[0] : "both"), size: 12, weight: cardMediumWeight, color: cardBrighterColor),
                    )
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: widget.studentRequest.sessionType.length == 2 ? 
                      CustomText(text: "Type: both", size: 12, weight: cardMediumWeight, color: cardBrighterColor) :
                      CustomText(text: "Type: " + (widget.studentRequest.sessionType.length == 1 ? widget.studentRequest.sessionType[0] : "both"), size: 12, weight: cardMediumWeight, color: cardBrighterColor)
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
          )
      );
    }
  }
}