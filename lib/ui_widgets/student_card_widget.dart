import 'dart:ui';
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../constants/style.dart' as style;

// ignore: must_be_immutable
class StudentCardWidget extends StatefulWidget{
  Enrollment enrollment;
  Function update;
  bool isNew;
  StudentCardWidget({ Key key, this.enrollment, this.update, this.isNew}) : super(key: key);

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
      print("Not editable update" + widget.enrollment.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Row descriptionSetup = Row(
      key: textKey,
      children: [
        CustomText(text : (widget.isNew ? "Needs help in " : "Takes help in "), weight: cardMediumWeight, color: cardBrighterColor.withOpacity(0)),
        CustomText(text : widget.enrollment.subject, weight: cardMediumWeight, color: cardBrighterColor.withOpacity(0), underline: true,)
      ],
    );

    Row description = Row(
      key: textKey,
      children: [
        CustomText(text : (widget.isNew ? "Needs help in " : "Takes help in "), weight: cardMediumWeight, color: cardBrighterColor),
        CustomText(text : widget.enrollment.subject, weight: cardMediumWeight, color: cardBrighterColor, underline: true,)
      ],
    );
    if (initFrame){
      return Wrap(children: [descriptionSetup]);
    }
    else{
      return Container(
        height:65+height.toDouble(),
        margin: const EdgeInsets.only(top: 10),
        decoration: widget.isNew ? commonNewStudentDecoration : commonCardDecoration,
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
                      text : widget.enrollment.studentName + " " + widget.enrollment.studentSurname, 
                      weight: cardBoldWeight, 
                      color: cardDarkerColor),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.bottomLeft,
                      child: description
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
          ],
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
      style: editableCardButtonStyle(widget.code == "Remove" || widget.code == "Decline" ? "delete" : "approve"),
      onPressed: ()async {
        if (widget.code == "Remove" || widget.code == "Decline"){
          globals.myAcceptedStudents.remove(widget.enrollment);
          globals.myNewStudents.remove(widget.enrollment);
          MyStudentsServices().deleteStudent(widget.enrollment.enrollmentId.toString());
        } else if (widget.code == "Approve"){
          globals.myNewStudents.remove(widget.enrollment);
          globals.myAcceptedStudents.add(widget.enrollment);
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
        color: style.almostDarkGrey, 
        weight: FontWeight.normal
      ),
    );
  }
}

