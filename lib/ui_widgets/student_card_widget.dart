import 'dart:ui';
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../constants/style.dart' as style;

// ignore: must_be_immutable
class StudentCardWidget extends StatefulWidget{
  User student;
  Card enrollmentCard;
  Enrollment enrollment;
  bool isNew;
  Function update;
  StudentCardWidget({ Key key, this.student, this.enrollmentCard, this.enrollment, this.isNew, this.update}) : super(key: key);

  @override
  _StudentCardWidgetState createState() => _StudentCardWidgetState();
}

class _StudentCardWidgetState extends State<StudentCardWidget>{
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
      print("Not editable update" + widget.enrollmentCard.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Row description = Row(
      key: textKey,
      children: [
        CustomText(text : (widget.isNew ? "Needs help in " : "Takes help in "), weight: FontWeight.normal, color: Colors.white),
        CustomText(text : widget.enrollmentCard.subject, weight: FontWeight.normal, color: Colors.white, underline: true,)
      ],
    );
    if (initFrame){
      return Wrap(children: [description]);
    }
    else{
      return Container(
          child: InkWell(
            child: Container(
              height:90+height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: commonCardDecoration,
              child: Container(
                alignment: Alignment.topLeft,
                child: 
                Column(children: [
                  Row(children: [
                    Flexible(
                      child: Column(
                        children: [
                          Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text : widget.student.name + " " + widget.student.surname, 
                            weight: FontWeight.bold, 
                            color: Colors.white),
                          ),
                          Container(
                            height: 30,
                          )
                        ],
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: widget.isNew ?
                          StudentCardButton(code : "Approve", update: widget.update, enrollment: widget.enrollment) :
                          StudentCardButton(code : "New Session", update: widget.update, enrollment: widget.enrollment)
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: widget.isNew ?
                          StudentCardButton(code : "Decline", update: widget.update, enrollment: widget.enrollment) :
                          StudentCardButton(code : "Remove", update: widget.update, enrollment: widget.enrollment)
                        ),
                    ],)
                  ],),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomLeft,
                      child: description
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

// ignore: must_be_immutable
class StudentCardButton extends StatefulWidget {
  String code;
  Function update;
  Enrollment enrollment;
  StudentCardButton({ Key key, this.code, this.update, this.enrollment}) : super(key: key);

  @override
  _StudentCardButtonState createState() => _StudentCardButtonState();
}

class _StudentCardButtonState extends State<StudentCardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: (widget.code == "Remove" || widget.code == "Decline") ? 
          MaterialStateProperty.all(style.pink.withOpacity(0.25)):
          MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Colors.white.withOpacity(0.5))
          )
        )
      ),
      onPressed: ()async {
        if (widget.code == "Remove" || widget.code == "Decline"){
          MyStudentsServices().deleteStudent(widget.enrollment.enrollmentId.toString());
        } else if (widget.code == "Approve"){
          MyStudentsServices().acceptStudent(widget.enrollment.enrollmentId.toString());
        } else if (widget == "New Session"){
          //TODO
        }
        setState(() {
            widget.update();
        });
      },
      child: CustomText(
        text: widget.code, 
        color: Colors.white,
      ),
    );
  }
}
