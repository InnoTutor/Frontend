import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/globals.dart' as globals;

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
      return newCard;
    }else{
      print("couldn't post the data of createCVCard");
      return card;
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

  // Future<EmployeeModel> updateEmployees(
  //     EmployeeModel employee, BuildContext context) async {
  //   var Url = "http://localhost:8080/updateemployee";
  //   var response = await http.put(Url,
  //       headers: <String, String>{"Content-Type": "application/json"},
  //       body: jsonEncode(employee));
  //   String responseString = response.body;
  //   if (response.statusCode == 200) {
  //      print(responseString);
  //   }
  // }
  // Future<Tutor> deleteEmployees(Tutor tutor) async {
  //   var Url = "http://localhost:8080/deleteemployee";
  //   var response = await delete(
  //     Uri.parse(urls.delete_tutor),
  //     headers: <String, String>{
  //       "Content-Type": "application/json;charset=UTF-8,"
  //     },
  //   );
  //   return Tutor.fromJson(jsonDecode(response.body));
  // }

}