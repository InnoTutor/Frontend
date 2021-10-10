import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

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
    CustomText descriptionText = CustomText(text : (widget.isNew ? "Needs help in " : "Takes help in ") + widget.enrollmentCard.subject, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    if (initFrame){
      return Wrap(children: [descriptionText]);
    }
    else{
      return !widget.enrollmentCard.hidden ? Container(
          child: InkWell(
            child: Container(
              height: 100+height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color : color,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
              ),
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
                          child: CustomText(text : widget.student.name + " " + widget.student.surname, weight: FontWeight.bold, color: Colors.white),
                          ),
                          Container(
                            height: 30,
                          )
                        ],
                      )
                    ),
                    Column(children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: ()async {
                            if (widget.isNew){
                              MyStudentsServices().acceptStudent(widget.enrollment.enrollmentId.toString());
                              setState(() {
                                widget.update();
                              });
                            } else {
                              // TODO
                            }
                          },
                          child: CustomText(text: widget.isNew ? "Approve" : "New Session", color: style.darkGrey, weight: FontWeight.bold,),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: style.pink
                          ),
                          onPressed: ()async {
                            MyStudentsServices().deleteStudent(widget.enrollment.enrollmentId.toString());
                            setState(() {
                                widget.update();
                            });
                          },
                          child: CustomText(text: widget.isNew ? "Decline" : "Remove", color: style.darkGrey, weight: FontWeight.bold,),
                        )
                      ),
                    ],)
                  ],),
                  // Expanded(
                  //   child: Container(height: 0,),
                  // ),
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
      ) : Wrap();
    }
  }
}