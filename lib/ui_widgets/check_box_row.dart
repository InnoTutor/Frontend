import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/globals.dart' as globals;
class CheckBoxRow extends StatefulWidget {
  Card card;
  Color color;
  Color themeColor;
  Function updateResults = null;
  Function updateDialog = null;
  bool radio = false;
  List<String> availableSessionFormats;
  List<String> availableSessionTypes;
  CheckBoxRow({ Key key, this.card, this.color, this.themeColor, this.updateResults, this.radio,
    this.availableSessionFormats, this.availableSessionTypes, this.updateDialog}) : super(key: key);

  @override
  _CheckBoxRowState createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {

  @override
  void initState() {
    super.initState();
    filterParams();
  }

  void filterParams(){
    setState(() {
      if (widget.availableSessionTypes != null){
        if (widget.availableSessionTypes.length == 1){
          manageParameters("type", widget.availableSessionTypes[0], true, false, true);
        }
      }
      
      if (widget.availableSessionFormats != null){
        if (widget.availableSessionFormats.length == 1){
          manageParameters("format", widget.availableSessionFormats[0], true, false, true);
        }
      }
    });
  }

  void manageParameters(String code, String param, bool value, bool radio, [bool filtering = false]) {
    setState(() {
      if (!radio){
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
      }

      if (!filtering && widget.updateDialog != null) widget.updateDialog();
      if (widget.updateResults != null) widget.updateResults(widget.card);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.radio == null) 
    setState(() {
      widget.radio = false;
    });
    return Row(
      children: [
        Flexible(
          child: CheckBoxGroup(
            themeColor: widget.themeColor,
            color: widget.color,
            card: widget.card,
            manageParameters: manageParameters, 
            code: "format", 
            param: globals.formats,
            radio: widget.radio,
            availableSessionFormats: widget.availableSessionFormats,
            availableSessionTypes: widget.availableSessionTypes,
          )
        ),
        Flexible(
          child: CheckBoxGroup(
            themeColor: widget.themeColor,
            color: widget.color,
            card: widget.card,
            manageParameters: manageParameters, 
            code: "type", 
            param: globals.types,
            radio: widget.radio,
            availableSessionFormats: widget.availableSessionFormats,
            availableSessionTypes: widget.availableSessionTypes,
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
  List<String> availableSessionFormats;
  List<String> availableSessionTypes;
  CheckBoxItem({ Key key, this.card, this.manageParameters, this.code, this.param, this.color, this.themeColor,
    this.availableSessionFormats, this.availableSessionTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isTypeFixed = availableSessionTypes != null ? availableSessionTypes.length == 1 : false;
    bool isFormatFixed = availableSessionFormats != null ? availableSessionFormats.length == 1 : false;

    bool value = isTypeFixed && code == "type" ? (param == availableSessionTypes.elementAt(0) ? true : false) :
      isFormatFixed && code == "format" ? (param == availableSessionFormats.elementAt(0) ? true : false) :
      code == "format" ? card.sessionFormat.contains(param) : 
      code == "type" ? card.sessionType.contains(param) : false;

    return new Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: themeColor,
      ),
      child: Row(
        children: [
          Checkbox(
            activeColor: style.almostDarkGrey,
            value: value,
            onChanged: !isTypeFixed && code == "type" || !isFormatFixed && code == "format" ? (bool newValue){
                if (manageParameters != (){}){
                  manageParameters(code, param, newValue, false);
                } 
              } : null
          ),
          CustomText(text: " " + param.toString(), color: color ?? Colors.white),
        ],
      ),
    );
  }
}


class RadioButtons extends StatefulWidget {
  Card card;
  Function manageParameters;
  String code;
  String param;
  Color color;
  Color themeColor;
  RadioButtons({ Key key, this.card, this.manageParameters, this.code, this.param, this.color, this.themeColor}) : super(key: key);

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  int val = -1;
   @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: widget.themeColor,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio(
              value: 1,
              groupValue: val,
              onChanged: (value) {
                  if (widget.manageParameters != (){}){
                    val = value;
                    if (widget.code == "format"){
                      if (val == value){
                        widget.card.sessionFormat = ["online"];
                      }
                    } else {
                      if (val == value){
                        widget.card.sessionType = ["private"];
                      }
                    }
                    widget.manageParameters("", "", false, true);
                  }
                  setState(() {
                });
              },
              activeColor: style.almostDarkGrey,
            ),
            CustomText(text: widget.code == "format" ? "online" : "private", color: widget.color ?? Colors.white),
            ],
          ),
          Row(
            children: [
              Radio(
              value: 2,
              groupValue: val,
              onChanged: (value) {
                  if (widget.manageParameters != (){}){
                    val = value;
                    if (widget.code == "format"){
                      if (val == value){
                        widget.card.sessionFormat = ["offline"];
                      }
                    } else {
                      if (val == value){
                        widget.card.sessionType = ["group"];
                      }
                    }
                    widget.manageParameters("", "", false, true);
                  }
                  setState(() {
                });
              },
              activeColor:style.almostDarkGrey,
            ),
            CustomText(text: widget.code == "format" ? "offline" : "group", color: widget.color ?? Colors.white),
            ],
          ),
          Row(
            children: [
              Radio(
              value: 3,
              groupValue: val,
              onChanged: (value) {
                  if (widget.manageParameters != (){}){
                    val = value;
                    if (widget.code == "format"){
                      if (val == value){
                        widget.card.sessionFormat = [];
                      }
                    } else {
                      if (val == value){
                        widget.card.sessionType = [];
                      }
                    }
                    widget.manageParameters("", "", false, true);
                  }
                  setState(() {
                });
              },
              activeColor:style.almostDarkGrey,
            ),
            CustomText(text: "both", color: widget.color ?? Colors.white),
            ],
          ),
        ],
      )
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
  bool radio = false;
  List<String> availableSessionFormats;
  List<String> availableSessionTypes;
  CheckBoxGroup({ Key key, this.card, this.manageParameters, this.code, this.param, this.color, this.themeColor, this.radio,
    this.availableSessionFormats, this.availableSessionTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children : [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: CustomText(text: code == "type" ? "Type:" : "Format:", weight: FontWeight.bold, color: color ?? Colors.white),
          ),
          !radio ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckBoxItem(card: card, manageParameters: manageParameters, code: code, param: param.elementAt(0), color: color, themeColor: themeColor,
                availableSessionFormats: availableSessionFormats, availableSessionTypes: availableSessionTypes),
              CheckBoxItem(card: card, manageParameters: manageParameters, code: code, param: param.elementAt(1), color: color, themeColor: themeColor,
                availableSessionFormats: availableSessionFormats, availableSessionTypes: availableSessionTypes)
            ],
          ) :
          RadioButtons(card: card, manageParameters: manageParameters, code: code, param: param.elementAt(0), color: color, themeColor: themeColor,)
        ]
      )
    );
  }
}