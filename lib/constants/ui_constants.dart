import 'package:flutter/material.dart';
import 'package:inno_tutor/constants/style.dart';

BoxShadow commonBoxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.03),
  spreadRadius: 5,
  blurRadius: 7,
);

BoxDecoration commonBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [commonBoxShadow]
);

BoxDecoration commonHiddenCardDecoration = BoxDecoration(
  color: almostDarkGrey,
  borderRadius: BorderRadius.all(Radius.circular(3)),
);

BoxDecoration commonCardDecoration = BoxDecoration(
  color: lightGreen,
  borderRadius: BorderRadius.all(Radius.circular(4)),
);

ButtonStyle editableCardButtonStyle(String button){
  return ButtonStyle(
    backgroundColor:
      MaterialStateProperty.all(button == "delete" ? pink.withOpacity(0.2) : Colors.white.withOpacity(0.2)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(color: Colors.white.withOpacity(0.5))
      )
    )
  );
}