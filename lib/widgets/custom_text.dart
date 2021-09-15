import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final String fontFamily;
  final bool selectable;

  const CustomText({ Key key,
   this.text, 
   this.size, 
   this.color, 
   this.weight,
   this.fontFamily,
   this.selectable }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selectable = selectable ?? false;
    if (_selectable) 
      return SelectableText(
        text, 
        style: TextStyle(
          fontFamily: fontFamily ?? 'SourceSans',
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: weight)
      );
    else
      return Text(
        text, 
        style: TextStyle(
          fontFamily: fontFamily ?? 'SourceSans',
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          fontWeight: weight)
      );
  }
}