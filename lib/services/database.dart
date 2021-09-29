import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/tutor.dart';
class TutorServices{
  Future<List<Tutor>> getTutors() async {
    Response res = await get(Uri.parse(Urls().get_tutors));

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
}