import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  color: almostDarkGrey.withOpacity(0.12),
  border: Border.symmetric(
    horizontal: BorderSide(color: almostDarkGrey.withOpacity(0.4))
  )
  //borderRadius: Border.Radius.all(Radius.circular(4)),
);

BoxDecoration commonCardDecoration = BoxDecoration(
  color: lightGreen.withOpacity(0.08),
  border: Border.symmetric(
    horizontal: BorderSide(color: lightGreen.withOpacity(0.4))
  )
  //borderRadius: BorderRadius.all(Radius.circular(4)),
);

BoxDecoration commonNewStudentDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.75),
  border: Border.symmetric(
    horizontal: BorderSide(color: almostDarkGrey.withOpacity(0.4))
  )
  //borderRadius: BorderRadius.all(Radius.circular(4)),
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

FontWeight cardBoldWeight = FontWeight.w600;
FontWeight cardMediumWeight = FontWeight.normal;
FontWeight cardLightWeight = FontWeight.w400;

Color cardDarkerColor = darkGrey;
Color cardBrighterColor = almostDarkGrey;