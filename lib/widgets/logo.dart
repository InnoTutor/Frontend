import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  final double leftPadding;
  final double rightPadding;
  final String path;

  const Logo({ Key key, 
    this.path,
    this.height, 
    this.leftPadding,
    this.rightPadding}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Image.asset(path ?? 'assets/icons/logo.png',
        fit: BoxFit.cover,
        height: height,
      )
    );
  }
}