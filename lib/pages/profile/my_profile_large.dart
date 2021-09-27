import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/widgets/cv_card.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';

class MyProfileLargePage extends StatefulWidget {
  @override
  _MyProfileLargeState createState() => _MyProfileLargeState();
}

class _MyProfileLargeState extends State<MyProfileLargePage> {
  User user;
  bool data_fetched=false;
  @override
  void initState() {
    fetch();
    super.initState();
  }
  Future<void> fetch()async{
    user = await AuthService().getUserData();
    setState(() {
      data_fetched=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return data_fetched ? Column(
      children: [
        PageCap(text: "My Profile"),
        Column(
          children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Image.network(user.imageUrl,
                    fit: BoxFit.cover,
                    height: 230,
                  )
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top:10),
                      child: CustomText(
                        text: user.name,
                        color: style.darkGrey,
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 0, top:10),
                      child: CustomText(
                        text: user.name,
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
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Column( 
                children: [
                  CVCard(subject: "Meth Analysis I", description: "Love this subject and love helping people. Got an A.",),
                  CVCard(subject: "Meth Analysis II", description: "Love this subject and love helping people. Got an A.",),
                  CVCard(subject: "Meth Analysis III", description: "Love this subject and love helping people. Got an A.",)
                ]
              )
            )
          ]
        )
      ],
    ) : Wrap();
  }
}