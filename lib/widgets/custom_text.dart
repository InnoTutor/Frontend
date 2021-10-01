import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final String fontFamily;
  final bool selectable;
  double width;

  CustomText({ Key key,
   this.text, 
   this.size, 
   this.color, 
   this.weight,
   this.fontFamily,
   this.selectable,
   this.width }) : super(key: key);

  Size textSize;

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
      return Container(
        width: width,
        child:Text(
          text, 
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
          style: TextStyle(
            fontFamily: fontFamily ?? 'SourceSans',
            fontSize: size ?? 16,
            color: color ?? Colors.black,
            fontWeight: weight)
        )
      );
  }
}