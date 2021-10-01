import 'dart:ui';

import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class EditableCvCardWidget extends StatefulWidget{
  Card card;
  EditableCvCardWidget({ Key key, this.card}) : super(key: key);

  @override
  _EditableCvCardWidgetState createState() => _EditableCvCardWidgetState();
}

class _EditableCvCardWidgetState extends State<EditableCvCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  bool editable = false;
  Icon currentIcon = Icon(Icons.create_rounded, color: Colors.white);
  String newDescription = "";
  final GlobalKey textKey = GlobalKey();
  int height = 100;

  void initState() {
    super.initState();
    newDescription = widget.card.description;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    setState(() {
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  void updateData(){
    for(Card card in myCards){
      if (card.cardId == widget.card.cardId){
        card = widget.card;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomText descriptionText = CustomText(text : newDescription, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    if (initFrame){
      return Wrap(children: [descriptionText]);
    }
    else{
      return Container( 
          child: InkWell(
            child: Container(
              height: 68+height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color : color,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                child: 
                Column(children: [
                  
                  Row(children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children : [
                            CustomText(text : widget.card.subject, weight: FontWeight.bold, color: Colors.white),
                            IconButton(
                              padding: EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 0),
                              icon: currentIcon,
                              constraints: BoxConstraints(),
                              onPressed: (){
                                setState(() {
                                  if (!editable){
                                    editable = true;
                                    height = height + 120;
                                    currentIcon = Icon(Icons.done, color: Colors.white);
                                  } else {
                                    editable = false;
                                    descriptionText.text= newDescription; 
                                    WidgetsBinding.instance
                                      .addPostFrameCallback((_) => updateHeight());
                                    currentIcon = Icon(Icons.create_rounded, color: Colors.white);
                                  }
                                });
                              },
                            ),
                          ]
                        )
                      )
                    ),
                    Column(children: [
                      Container(
                        padding: EdgeInsets.only(right:10, top:10),
                        child: RatingBar(
                          itemSize: 18,
                          initialRating: widget.card.rating,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.white),
                            half: Icon(Icons.star_half, color: Colors.white),
                            empty: Icon(Icons.star_border, color: Colors.white),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(text: "                 " + widget.card.peopleVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: Colors.white,)
                      )
                    ],)
                  ],),
                  // Expanded(
                  //   child: Container(height: 0,),
                  // ),
                  Flexible(
                    child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomLeft,
                    child: !editable ? 
                      descriptionText :
                      TextFormField (
                        initialValue: descriptionText.text,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        style: TextStyle(fontFamily: 'SourceSans', color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey
                        ),
                        onChanged: (text) {
                          widget.card.description = text;
                          newDescription = text;
                        },
                        
                      )
                    )
                  ),
                  editable ? 
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: Row(
                            children : [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: CustomText(text: "Format:", weight: FontWeight.bold, color: Colors.white),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: style.darkGreen,
                                        value: widget.card.sessionFormat.contains("online"), 
                                        onChanged: (bool newValue){
                                          if (newValue == false){
                                            widget.card.sessionFormat.remove("online");
                                          } else {
                                            widget.card.sessionFormat.add("online");
                                          }
                                        }
                                      ),
                                      CustomText(text: " online", color: Colors.white),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: style.darkGreen,
                                        value: widget.card.sessionFormat.contains("offline"), 
                                        onChanged: (bool newValue){
                                          if (newValue == false){
                                            widget.card.sessionFormat.remove("offline");
                                          } else {
                                            widget.card.sessionFormat.add("offline");
                                          }
                                        }
                                      ),
                                      CustomText(text: " offline", color: Colors.white),
                                    ],
                                  )
                                ],
                              )
                            ]
                          )
                        )
                      ),
                      Flexible(
                        child: Container(
                          child: Row(
                            children : [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: CustomText(text: "Type:", weight: FontWeight.bold, color: Colors.white),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: style.darkGreen,
                                        value: widget.card.sessionType.contains("public"), 
                                        onChanged: (bool newValue){
                                          if (newValue == false){
                                            widget.card.sessionType.remove("public");
                                          } else {
                                            widget.card.sessionType.add("public");
                                          }
                                        }
                                      ),
                                      CustomText(text: " public", color: Colors.white),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: style.darkGreen,
                                        value: widget.card.sessionType.contains("private"), 
                                        onChanged: (bool newValue){
                                          if (newValue == false){
                                            widget.card.sessionType.remove("private");
                                          } else {
                                            widget.card.sessionType.add("private");
                                          }
                                        }
                                      ),
                                      CustomText(text: " private", color: Colors.white),
                                    ],
                                  )
                                ],
                              )
                            ]
                          )
                        )
                      )
                    ]
                  ) : Wrap()
                ],
              ),
              )
            ),
            // onTap: () {
            
            // },
            // onHover: (isHovering){
            //   setState(() {
            //     if (isHovering){
            //       color = style.grey;
            //     } else{
            //       color = style.darkGreen;
            //     }
            //   });
            // }
          )
      );
    }
  }
}