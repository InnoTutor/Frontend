import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class TutorCardWidget extends StatefulWidget{
  Tutor tutor;
  TutorCardWidget({ Key key, this.tutor}) : super(key: key);

  @override
  _TutorCardWidgetState createState() => _TutorCardWidgetState();
}

class _TutorCardWidgetState extends State<TutorCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  final GlobalKey textKey = GlobalKey();
  int height = 100;

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      print("Not editable update" + widget.tutor.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomText descriptionText = CustomText(text : widget.tutor.description, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
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
                      child: CustomText(text : widget.tutor.subject, weight: FontWeight.bold, color: Colors.white),
                      )
                    ),
                    Column(children: [
                      Container(
                        padding: EdgeInsets.only(right:10, top:10),
                        child: RatingBar(
                          itemSize: 18,
                          initialRating: widget.tutor.rating ?? 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.white),
                            half: Icon(Icons.star_half, color: Colors.white),
                            empty: Icon(Icons.star_border, color: Colors.white),
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ),
                      Container(
                        //padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: CustomText(text: "                 " + widget.tutor.countVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: Colors.white,)
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
                    child: descriptionText
                    )
                  )
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