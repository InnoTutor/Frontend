import 'package:flutter/material.dart';

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