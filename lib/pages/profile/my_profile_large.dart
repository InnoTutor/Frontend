import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/constants/style.dart' as style;
import 'package:inno_tutor/widgets/custom_text.dart';
import 'package:inno_tutor/widgets/page_cap.dart';

class MyProfileLargePage extends StatelessWidget {
  const MyProfileLargePage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageCap(text: "My Profile"),
        Column(
          children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('images/profile_picture.png',
                    /*
                      TODO: Connect with data base
                    */
                    fit: BoxFit.cover,
                    height: 230,
                  )
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 5, top:10),
                      child: CustomText(
                        text: "Name Surname",
                        /*
                          TODO: Connect with data base
                        */
                        color: style.darkGrey,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 0, top:10),
                      child: CustomText(
                        text: "Third year student.",
                        /*
                          TODO: Connect with data base
                        */
                        color: style.darkGrey,
                        size: 16,
                        weight: FontWeight.normal,
                      ),
                    )
                  ]
                )
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, top: 10),
              child: CustomText(
                text: "My Services:",
                color: style.darkGrey,
                size: 18,
                weight: FontWeight.bold,
              )
            )
          ]
        )
      ],
    );
  }
}