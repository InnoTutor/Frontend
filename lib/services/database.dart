import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/models/tutor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services{
  Urls urls = Urls();
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Authorization" :"Bearer " + globals.user.token
  };
  Future<List<Card>> getCvCards() async{
    Response res = await get(Uri.parse(Urls.my_cvcard),headers: headers);
    if (res.statusCode == 200) {

      final obj = jsonDecode(res.body);
      List<Card>cards=[];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);

        card.setEditable(false);
        card.setHeight(100);
        cards.add(card);
      }
      return cards;
    } else {
      throw "Unable to get cards data.";
    }
  }
  Future<List<Card>> getTutors() async {

  }
  // create request card
  Future<Card> createRequestCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    var response = await post(Uri.parse(Urls.request_card),
        headers: headers,
        body: json.encode(data)
    );

    print(response.body);
    if (response.statusCode == 200) {
       Card card = Card.fromJson(jsonDecode(response.body));
       return card;
    }
  }
  // create cv card
  Future<Card> createCvCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    data.remove('hidden');
    data.remove('height');
    data.remove('rating');
    data.remove('creatorId');
    data.remove('countVoted');
    data.remove('editable');
    data.remove('currentIcon');
    print(data);
    print(jsonEncode(data));
    var response = await post(Uri.parse(Urls.my_cvcard),
        headers: headers,
        body: jsonEncode(data)
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      Card newCard = Card.fromJson(jsonDecode(response.body));
      newCard.initializeCard();

      globals.myCards.add(newCard);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));

      return newCard;
    }else{
      print("couldn't post the data of createCVCard");
      return card;
    }
  }
  Future<Card> updateCvCard(Card card)async{
    print("will update a card now");
    String url = Urls.my_cvcard + '/'+card.cardId.toString();

    var response = await put(Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(card)
    );
    String responseString = response.body;
    if (response.statusCode == 200 || response.statusCode==201) {
      // todo
      // update mycards and shared preferences
    } else {
      print(response.statusCode);
    }
  }
  Future<Card> deleteCvCard(Card card)async{

    String url = Urls.my_cvcard + '/'+card.cardId.toString();
    print(url);
    var response = await delete(Uri.parse(url),
      headers: headers,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200 || response.statusCode==201) {
      globals.myCards.remove(card);
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      print(response.body);
    }else {
      print(response.statusCode);
      print('couldnt delete a card');
    }
  }
  Future<List<String>> getSubjects() async{
    List<String>subject_names=[];
    print("I'm in subject names helloooozz ");

    Response res = await get(Uri.parse(Urls.subjects),headers: headers);
    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<Subject> subjects =  [];
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subjects.add(subject);

        subject_names.add(subject.name);
      }
      return subject_names;

    } else {
      throw "Unable to get subjects.";
    }
  }


  Future<Tutor> DeleteTutor(Tutor tutor) async {

  }

}