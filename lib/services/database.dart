import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/tutor.dart';

class Services{
  Urls urls = Urls();

  Future<List<Tutor>> getTutors() async {
    Response res = await get(Uri.parse(urls.get_tutors));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      print(obj);
      List<Tutor> tutors =  new List<Tutor>();

      for (int i = 0; i < obj.length; i++) {
        Tutor tutor = Tutor.fromJson(obj[i]);
        tutors.add(tutor);
      }

      return tutors;
    } else {
      throw "Unable to retrieve stock data.";
    }
  }
  // create request card
  Future<void> createRequestCard(Card card) async {
    final data = card.toJson();
    data.remove('cardId');
    var response = await post(Uri.parse(urls.request_card),
        headers: <String, String>{"Content-Type": "application/json"},
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
    var response = await post(Uri.parse(urls.cv_card),
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