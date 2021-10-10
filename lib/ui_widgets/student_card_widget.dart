import 'package:flutter/material.dart' hide Card;
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/style.dart' as style;

class StudentCardWidget extends StatefulWidget{
  Enrollment enrollment;
  Function updateMyStudents;
  StudentCardWidget({ Key key, this.enrollment, this.updateMyStudents}) : super(key: key);

  @override
  _StudentCardWidgetState createState() => _StudentCardWidgetState();
}

class _StudentCardWidgetState extends State<StudentCardWidget>{
  Color color = style.darkGreen;
  bool initFrame = true;
  final GlobalKey textKey = GlobalKey();
  int height = 100;
  Card studentCard;
  bool card_fetched = false;

  void initState() {
    super.initState();
    fetch_card();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateHeight());
  }

  Future<void> fetch_card() async {
    studentCard = await CardServices().getCvCard(widget.enrollment.cardId);
    setState(() {
      card_fetched = true;
    });
  }

  void updateHeight(){
    RenderBox params = textKey.currentContext.findRenderObject();
    if(mounted)
      setState(() {
      print("Not editable update" + studentCard.height.toString());
      height = params.size.height.toInt();
      initFrame = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomText descriptionText = CustomText(text : studentCard.description, weight: FontWeight.normal, color: Colors.white, width: 660, key: textKey);
    if (initFrame){
      return Wrap(children: [descriptionText]);
    }
    else{
      return card_fetched ? Container(
          child: InkWell(
            child: Container(
              height: 100+height.toDouble(),
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
                      child: CustomText(text : studentCard.subject, weight: FontWeight.bold, color: Colors.white),
                      )
                    ),
                    Column(children: [
                      // Container(
                      //   padding: EdgeInsets.only(right:10, top:10),
                      //   child: RatingBar(
                      //     itemSize: 18,
                      //     initialRating: studentCard.rating ?? 0,
                      //     direction: Axis.horizontal,
                      //     allowHalfRating: true,
                      //     itemCount: 5,
                      //     ratingWidget: RatingWidget(
                      //       full: Icon(Icons.star, color: Colors.white),
                      //       half: Icon(Icons.star_half, color: Colors.white),
                      //       empty: Icon(Icons.star_border, color: Colors.white),
                      //     ),
                      //     ignoreGestures: true,
                      //     onRatingUpdate: (rating) {
                      //       print(rating);
                      //     },
                      //   )
                      // ),
                      // Container(
                      //   //padding: EdgeInsets.only(left: 10),
                      //   alignment: Alignment.centerLeft,
                      //   child: CustomText(text: "                 " + widget.tutor.countVoted.toString() + " voted", size: 12, weight: FontWeight.w400, color: Colors.white,)
                      // ),  
                    ],)
                  ],),
                  // Expanded(
                  //   child: Container(height: 0,),
                  // ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: studentCard.sessionFormat.length == 2 ? 
                      CustomText(text: "Format: both", size: 12, weight: FontWeight.w400, color: Colors.white,) :
                      CustomText(text: "Format: " + studentCard.sessionFormat[0], size: 12, weight: FontWeight.w400, color: Colors.white,),
                    )
                  ),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: studentCard.sessionType.length == 2 ? 
                      CustomText(text: "Type: both", size: 12, weight: FontWeight.w400, color: Colors.white,) :
                      CustomText(text: "Type: " + studentCard.sessionType[0], size: 12, weight: FontWeight.w400, color: Colors.white,)
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
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
      ) : Wrap();
    }
  }
}