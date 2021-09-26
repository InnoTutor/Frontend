import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import '../constants/style.dart' as style;

class CVCard extends StatefulWidget{
  String subject;
  String description;
  CVCard({ Key key, this.subject, this.description}) : super(key: key);

  @override
  _CVCardState createState() => _CVCardState();
}

class _CVCardState extends State<CVCard>{
  Color color = style.darkGreen;

  @override
  Widget build(BuildContext context) {
    return Container( 
        child: InkWell(
          child: Container(
            height: 80,
            margin: const EdgeInsets.only(right:5, left:5, top: 10),
            decoration: BoxDecoration(
              color : color,
              borderRadius:  BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              child: 
              Column(children: [
                Flexible(
                  child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: CustomText(text : widget.subject, weight: FontWeight.bold, color: Colors.white),
                  )
                ),
                // Expanded(
                //   child: Container(height: 0,),
                // ),
                Flexible(
                  child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: CustomText(text : widget.description, weight: FontWeight.normal, color: Colors.white)
                  )
                )
              ],
            ),
            )
          ),
          onTap: () {},
          onHover: (isHovering){
            setState(() {
              if (isHovering){
                color = style.grey;
              } else{
                color = style.darkGreen;
              }
            });
          }
        )
    );
  }
}