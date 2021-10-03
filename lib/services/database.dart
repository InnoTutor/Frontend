import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/tutor.dart';

class Services{
  Urls urls = Urls();
  Map<String, String> headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };
  Future<List<Card>> getTutors() async {

    Response res = await get(Uri.parse(Urls.get_tutors));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      print(obj);
      List<Card> cards =  [];

      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        cards.add(card);
        // print('\n\n\n');
        // print(card.toJson());
      }
      for(Card card in cards){
        card.setEditable(false);
        card.setHeight(100);
      }
      print('\n\n\n');

      print('end of the file');

      return cards;
    } else {
      throw "Unable to cards data.";
    }
  }
  // create request card
  Future<void> createRequestCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    var response = await post(Uri.parse(Urls.request_card),
        headers: <String, String>{
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
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
    var response = await post(Uri.parse(Urls.cv_card),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(data)
    );

    print(response.body);
    if (response.statusCode == 200) {

      // Card card = Card.fromJson(response.body);
      // return card;
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