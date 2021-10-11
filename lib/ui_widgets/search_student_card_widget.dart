import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class SearchStudentCardWidget extends StatefulWidget{
  User user;
  StudentRequest studentRequest;
  SearchStudentCardWidget({ Key key, this.user, this.studentRequest}) : super(key: key);

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

    CustomText descriptionText = CustomText(text : widget.studentRequest.description, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    if (initFrame){
      return Wrap(children: [descriptionText]);
    }
    else{
      return Container(
          child: InkWell(
            child: Container(
              height: 100+height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color : color,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                child: 
                Column(children: [
                  
                  Row(children: [
                    Flexible(
                      child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: CustomText(text : widget.user.name + " " + widget.user.surname + ", " + widget.studentRequest.subject, weight: FontWeight.bold, color: Colors.white),
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
                      CustomText(text: "Format: both", size: 12, weight: FontWeight.w400, color: Colors.white,) :
                      CustomText(text: "Format: " + (widget.studentRequest.sessionFormat.length == 1 ? widget.studentRequest.sessionFormat[0] : "both"), size: 12, weight: FontWeight.w400, color: Colors.white,),
                    )
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: widget.studentRequest.sessionType.length == 2 ? 
                      CustomText(text: "Type: both", size: 12, weight: FontWeight.w400, color: Colors.white,) :
                      CustomText(text: "Type: " + (widget.studentRequest.sessionType.length == 1 ? widget.studentRequest.sessionType[0] : "both"), size: 12, weight: FontWeight.w400, color: Colors.white,)
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