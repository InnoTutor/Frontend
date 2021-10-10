import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/widgets/custom_text.dart';

class CustomDropDownButton extends StatefulWidget {
  Card card;
  List<String> locations;
  String selectedLocation = "";
  double width;
  Function updateResults = null;
  CustomDropDownButton({ Key key, this.locations, this.selectedLocation, this.card, this.width, this.updateResults}) : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 600,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: style.grey,
        borderRadius:  BorderRadius.all(Radius.circular(10)),
      ),
      child: DropdownButton(
        itemHeight: kMinInteractiveDimension,
        iconEnabledColor: style.lightGrey,
        dropdownColor: style.grey,
        focusColor: style.darkGrey,
        borderRadius: BorderRadius.circular(10),
        hint: CustomText(text: widget.card.subject == "" ? "Choose subject" : widget.card.subject, color: style.darkGrey, weight: FontWeight.bold,),
        value: widget.selectedLocation,
        onChanged: (newValue) {
          if(mounted)
            setState(() {
            widget.card.subject = newValue;
            widget.selectedLocation = newValue;
            if (widget.updateResults != null) widget.updateResults(widget.card);
          });
        },
        items: widget.locations.map((location) {
          return DropdownMenuItem(
            child: new CustomText(text: location, color: style.darkGrey, weight: FontWeight.bold,),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}