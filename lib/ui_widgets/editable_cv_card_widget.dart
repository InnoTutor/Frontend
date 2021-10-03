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
  bool initFrame = true;
  bool heightUpdateNeeded = true;
  String reserveButtonText = "";
  final GlobalKey textKey = GlobalKey();

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    setState(() {
      widget.card.height = params.size.height.toInt();
      print("Editable set state " + widget.card.height.toString());
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
    print("Editable build" + widget.card.height.toString());
    CustomText descriptionText = CustomText(text : widget.card.description, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    reserveButtonText = widget.card.isReserved ? "Unreserve" : "Reserve";
    if (initFrame){
      return Wrap(children: [descriptionText]);
    }
    else{
      if (heightUpdateNeeded){
        updateHeight();
      } 
      return Container( 
          child: InkWell(
            child: Container(
              height: 68+widget.card.height.toDouble(),
              margin: const EdgeInsets.only(right:5, left:5, top: 10),
              decoration: BoxDecoration(
                color : widget.card.isReserved ? style.darkGrey : style.darkGreen,
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
                              icon: icons[widget.card.currentIcon],
                              constraints: BoxConstraints(),
                              onPressed: (){
                                setState(() {
                                  if (!widget.card.editable){
                                    print("here1");
                                    widget.card.editable = true;
                                    widget.card.height = widget.card.height + 150;
                                    heightUpdateNeeded = false;
                                    widget.card.currentIcon = 0;
                                  } else {
                                    print("here2");
                                    widget.card.editable = false;
                                    WidgetsBinding.instance
                                      .addPostFrameCallback((_) => updateHeight());
                                    widget.card.currentIcon = 1;
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
                        child:AbsorbPointer(
                          // child: RatingBar(
                          //   itemSize: 18,
                          //   initialRating: widget.card.rating,
                          //   direction: Axis.horizontal,
                          //   allowHalfRating: true,
                          //   itemCount: 5,
                          //   ratingWidget: RatingWidget(
                          //     full: Icon(Icons.star, color: Colors.white),
                          //     half: Icon(Icons.star_half, color: Colors.white),
                          //     empty: Icon(Icons.star_border, color: Colors.white),
                          //   ),
                          //   ignoreGestures: true,
                          //   onRatingUpdate: (rating) {
                          //     print(rating);
                          //   },
                          // )
                          child: Wrap(),
                        )
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(text: "                 " + widget.card.countVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: Colors.white,)
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
                    child: !widget.card.editable ? 
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
                        },
                        
                      )
                    )
                  ),
                  widget.card.editable ? 
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
                  ) : Wrap(),
                  widget.card.editable ?
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: style.pink
                          ),
                          onPressed: () {
                            // myCards.remove(widget.card);
                          },
                          child: CustomText(text: "Delete", color: style.darkGrey, weight: FontWeight.bold,),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white
                          ),
                          onPressed: () {
                            if (!widget.card.isReserved){
                              widget.card.isReserved = true;
                              setState(() {
                                reserveButtonText = "Unreserve";
                              });
                            } else {
                              widget.card.isReserved = false;
                              setState(() {
                                reserveButtonText = "Reserve";
                              });
                            }
                          },
                          child: CustomText(text: reserveButtonText, color: style.darkGrey, weight: FontWeight.bold,),
                        ),
                      ),
                    ],
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