import 'dart:async';

import 'package:flutter/material.dart' hide Card;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inno_tutor/fake_data.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/services/database.dart';
import 'package:inno_tutor/ui_widgets/cv_card_widget.dart';
// import 'package:inno_tutor/services/database.dart';
import '../../constants/style.dart' as style;
import '../../widgets/custom_text.dart';
import '../../widgets/page_cap.dart';
import 'package:inno_tutor/globals.dart' as globals;

class MyProfileLargePage extends StatefulWidget {
  @override
  _MyProfileLargeState createState() => _MyProfileLargeState();
}

class _MyProfileLargeState extends State<MyProfileLargePage> {
  var cards = List<Card>.generate(200, (index) => null);

  bool data_fetched = false;
  @override
  initState() {
    super.initState();
    fetch();
    fetch_cards('');
  }
  fetch()async{
    if(globals.user == null){
     globals.user= await AuthService().getUserData();

    }
  }
  Future<List<Card>> fetch_cards(String search) async {
    Services services = new Services();
    myCards = await services.getTutors();
    print(myCards[0]);
    print('ana fe fetch cards');
    return myCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                PageCap(text: "My Profile"),
                Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Image.network(
                            globals.user.imageUrl,
                            fit: BoxFit.cover,
                            height: 230,
                          )),
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: CustomText(
                            text: globals.user.name,
                            color: style.darkGrey,
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 0, top: 10),
                          child: CustomText(
                            text: globals.user.name,
                            color: style.darkGrey,
                            size: 16,
                            weight: FontWeight.normal,
                          ),
                        )
                      ])
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
                      )),
                  Expanded(
                    child: SizedBox(
                      height: 200.0,

                      child: FutureBuilder<List<Card>>(
                          future:
                              fetch_cards(''), // stream data to listen for change
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Card>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == null) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        Colors.teal),
                                  ),
                                );
                              }
                              return ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Card card = snapshot.data[index];
                                    print('instead the listview');
                                    print(card.toJson());
                                   // return ListTile(
                                   //      title: Text('ID' + ' ' + 'First Name' + ' ' + 'Last Name'),
                                   //  subtitle: Text('${snapshot.data[index].subject}' +
                                   //  '${snapshot.data[index].description}' +
                                   //  '${snapshot.data[index].currentIcon}'),
                                   //  );
                                    return CvCardWidget(card: card);
                                  });
                            }
                            return Wrap();
                          }),
                    ),
                  ),
                ])
              ],
            );


  }
}
