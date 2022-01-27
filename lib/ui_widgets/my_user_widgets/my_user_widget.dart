import 'dart:ui';
import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart';
import 'package:inno_tutor/constants/ui_constants.dart';
import 'package:inno_tutor/models/accept_models/accept_model.dart';
import 'package:inno_tutor/models/accept_models/my_student.dart';
import 'package:inno_tutor/models/accept_models/my_tutor.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_text.dart';

// ignore: must_be_immutable
class MyUserWidget extends StatefulWidget{
  AcceptModel user;
  Function update;
  bool isNew;
  MyUserWidget({ Key key, this.user, this.update, this.isNew}) : super(key: key);

  @override
  _MyUserWidgetState createState() => _MyUserWidgetState();
}

class _MyUserWidgetState extends State<MyUserWidget>{
  Color color = darkGreen;
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
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  Container heading(){
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: CustomText(
        text : widget.user.name + " " + widget.user.surname, 
        weight: cardBoldWeight, 
        color: cardDarkerColor),
    );
  }

  Container description(Row description){
    return Container(
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.bottomLeft,
      child: description
    );
  }

  Column buttons(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: widget.isNew ?
            UserCardButton(code : "Approve", update: widget.update, user: widget.user) :
            UserCardButton(code : "New Session", update: widget.update, user: widget.user)
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 5, right: 10),
            child: widget.isNew ?
            UserCardButton(code : "Decline", update: widget.update, user: widget.user) :
            UserCardButton(code : "Remove", update: widget.update, user: widget.user)
          ),
    ],);
  }


  @override
  Widget build(BuildContext context) {
    
    Row _descriptionText({bool setup = false}){
      return Row(
        key: textKey,
        children: [
          CustomText(
            text :
              widget.user is MyStudent ?
              (widget.isNew ? "Needs help in " : "Takes help in ") :
              widget.user is MyTutor ?
              (widget.isNew ? "Offers help in " : "Helps in ") : "", 
            weight: cardMediumWeight, 
            color: cardBrighterColor.withOpacity(setup ? 0 : 1)),
          CustomText(
            text : widget.user.subject, 
            weight: cardMediumWeight, 
            color: cardBrighterColor.withOpacity(setup ? 0 : 1), 
            underline: true,)
        ],
      );
    }

    Row descriptionSetup = _descriptionText(setup: true);
    Row descriptionRow = _descriptionText();

    if (initFrame){
      return Wrap(children: [descriptionSetup]);
    }
    else{
      return Container(
        height: 65 + height.toDouble(),
        margin: EdgeInsets.only(top: 10),
        decoration: widget.isNew ? commonNewStudentDecoration : commonCardDecoration,
        child: Container(
          alignment: Alignment.topLeft,
          child: 
          Column(children: [
            Row(children: [
              Flexible(
                child: Column(
                  children: [
                    heading(),
                    description(descriptionRow)
                  ],
                )
              ),
              buttons()
            ],),
          ],
        ),
        )
      );
    }
  }
}

// ignore: must_be_immutable
class UserCardButton extends StatefulWidget {
  String code;
  Function update;
  AcceptModel user;
  UserCardButton({ Key key, this.code, this.update, this.user}) : super(key: key);

  @override
  _UserCardButtonState createState() => _UserCardButtonState();
}

class _UserCardButtonState extends State<UserCardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: editableCardButtonStyle(widget.code == "Remove" || widget.code == "Decline" ? "delete" : "approve"),
      onPressed: ()async {
        if (widget.code == "Remove" || widget.code == "Decline"){
          widget.user is MyStudent ?
          MyStudentsServices().deleteStudent(widget.user.enrollmentId.toString()) :
          widget.user is MyTutor ?
          MyTutorsServices().deleteTutor(widget.user.enrollmentId.toString()) : (){};
          widget.update("remove", user: widget.user);
        } else if (widget.code == "Approve"){
          widget.user is MyStudent ?
          MyStudentsServices().acceptStudent(widget.user.enrollmentId.toString()) :
          widget.user is MyTutor ?
          MyTutorsServices().acceptTutor(widget.user.enrollmentId.toString()) : (){};
          widget.update("approve", user: widget.user);
        } else if (widget == "New Session"){
          //TODO
        }
      },
      child: CustomText(
        text: widget.code, 
        color: almostDarkGrey, 
        weight: FontWeight.normal
      ),
    );
  }
}

