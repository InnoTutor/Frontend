import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart'; 
import 'package:inno_tutor/widgets/custom_text.dart';

class CheckBoxRow extends StatefulWidget {
  Card card;
  Color color;
  Color themeColor;
  CheckBoxRow({ Key key, this.card, this.color, this.themeColor}) : super(key: key);

  @override
  _CheckBoxRowState createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  void manageParameters(String code, String param, bool value){
    setState(() {
      if (code == "format"){
        if (value){
          widget.card.sessionFormat.add(param);
        } else {
          widget.card.sessionFormat.remove(param);
        }
      } else if (code == "type"){
        if (value){
          widget.card.sessionType.add(param);
        } else {
          widget.card.sessionType.remove(param);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CheckBoxGroup(
            themeColor: widget.themeColor,
            color: widget.color,
            card: widget.card,
            manageParameters: manageParameters, 
            code: "format", 
            param: ["online", "offline"]
          )
        ),
        Flexible(
          child: CheckBoxGroup(
            themeColor: widget.themeColor,
            color: widget.color,
            card: widget.card,
            manageParameters: manageParameters, 
            code: "type", 
            param: ["public", "private"]
          )
        )
      ]
    );
  }
}

class CheckBoxItem extends StatelessWidget {
  Card card;
  Function manageParameters;
  String code;
  String param;
  Color color;
  Color themeColor;
  CheckBoxItem({ Key key, this.card, this.manageParameters, this.code, this.param, this.color, this.themeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: themeColor,
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: style.darkGreen,
            value: code == "format" ? card.sessionFormat.contains(param) : code == "type" ? card.sessionType.contains(param) : false, 
            onChanged: (bool newValue){
              if (manageParameters != (){})
                manageParameters(code, param, newValue);
            }
          ),
          CustomText(text: " " + param.toString(), color: color ?? Colors.white),
        ],
      ),
    );
  }
}

class CheckBoxGroup extends StatelessWidget {
  Card card;
  Function manageParameters;
  String code;
  List<String> param;
  Color color;
  Color themeColor;
  CheckBoxGroup({ Key key, this.card, this.manageParameters, this.code, this.param, this.color, this.themeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children : [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: CustomText(text: "Type:", weight: FontWeight.bold, color: color ?? Colors.white),
          ),
          Column(
            children: [
              CheckBoxItem(card: card, manageParameters: manageParameters, code: code, param: param.elementAt(0), color: color, themeColor: themeColor,),
              CheckBoxItem(card: card, manageParameters: manageParameters, code: code, param: param.elementAt(1), color: color, themeColor: themeColor,)
            ],
          )
        ]
      )
    );
  }
}