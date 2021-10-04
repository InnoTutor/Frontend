import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/services/auth.dart';

class Services{
  Urls urls = Urls();
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Authorization" :"Bearer " + globals.user.token
  };
  Future<List<Card>> getCvCards() async{
    if(globals.user.token == null){
      globals.user.token = await AuthService().extractToken();
    }
    Response res = await get(Uri.parse(Urls.cv_card),headers: headers);

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<Card> cards =  [];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        cards.add(card);

      }
      for(Card card in cards){
        card.setEditable(false);
        card.setHeight(100);
      }

      return cards;
    } else {
      throw "Unable to cards data.";
    }
  }
  Future<List<Card>> getTutors() async {

  }
  // create request card
  Future<void> createRequestCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    var response = await post(Uri.parse(Urls.request_card),
        headers: headers,
        body: json.encode(data)
    );

    print(response.body);
    if (response.statusCode == 200) {
       // Card card = Card.fromJson(response.body);
       // return card;
    }
  }
  // create cv card
  Future<void> createCvCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    if(globals.user.token == null){
      globals.user.token = await AuthService().extractToken();
    }
    var response = await post(Uri.parse(Urls.cv_card),
        headers: headers,
        body: json.encode(data)
    );
    print("I'm in create CV card");
    print(response.body);
    if (response.statusCode == 200) {
      Card card = Card.fromJson(jsonDecode(response.body));
      return card;
    }
  }
  Future<List<Subject>> getSubjects() async{
    if(globals.user.token == null){
      globals.user.token = await AuthService().extractToken();
    }
    Response res = await get(Uri.parse(Urls.subjects),headers: headers);
    print('getting subjects');
    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      List<Subject> subjects =  [];
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subjects.add(subject);
      }
      return subjects;

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