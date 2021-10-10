import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
import 'package:inno_tutor/models/requested_students.dart';
import 'package:inno_tutor/models/session.dart';
import 'package:inno_tutor/models/session_format.dart';
import 'package:inno_tutor/models/session_type.dart';
import 'package:inno_tutor/models/student_request.dart';
import 'package:inno_tutor/models/subject.dart';
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/models/tutor.dart';
import 'package:inno_tutor/models/user.dart';
import 'package:inno_tutor/services/auth.dart';
import 'package:inno_tutor/services/global_funtions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  Future<User> getUser(String userId) async {
    Response res = await get(Uri.parse((Urls.get_user + userId)),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      User user = User.fromJson(jsonDecode(res.body));
      print('got user data successfully');
      return user;
    } else {
      throw "Unable to get user data.";
    }
  }

  Future<User> getProfile() async {
    return await getUser(globals.user.userId.toString());
  }

  Future<User> editProfile(User user) async {
    Response res = await put(Uri.parse((Urls.profile)),
        headers: await headers(), body: removeExtraParameters().profile(user));
    if (res.statusCode == 200 || res.statusCode == 201) {
      User user = User.fromJson(jsonDecode(res.body));
      print('user profile has been updated successfully');
      return user;
    } else {
      throw "Unable to update user profile.";
    }
  }
}

class Services {
  Future<List<Card>> getUserCards(String userId) async {
    Response res = await get(Uri.parse((Urls.get_user_services+userId)),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Card> cards = [];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        card.initializeCard();
        cards.add(card);
      }
      print("got cv cards for user: "+userId);
      return cards;
    }else {
      throw ("Unable to get cv cards data for user: "+userId);
    }
  }
  Future<List<Card>> getMyCvCards() async {
    Response res = await get(Uri.parse(Urls.services),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Card> cards = [];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        card.initializeCard();
        cards.add(card);
      }
      print("got cv cards successfully");

      return cards;
    } else {
      throw "Unable to get cards data.";
    }
  }
  Future<List<String>> getSubjects() async {
    List<String> subject_names = [];
    Response res =
    await get(Uri.parse(Urls.services_subjects), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subject_names.add(subject.name);
      }
      print('got services subjects successfully');
      return subject_names;
    } else {
      throw "Unable to get services subjects.";
    }
  }

  Future<Card> create(Card card) async {
    var response = await post(
      Uri.parse(Urls.services),
      headers: await headers(),
      body: removeExtraParameters().card(card),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Card newCard = Card.fromJson(jsonDecode(response.body));
      newCard.initializeCard();
      globals.myCards.add(newCard);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(
          'my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      print("a Cv card has been created successfully");
      return newCard;
    } else {
      throw "couldn't create a new cv card";
    }
  }


  Future<Card> edit(Card card) async {
    String url = Urls.services + '/' + card.cardId.toString();
    var response = await put(Uri.parse(url),
        headers:await headers(), body: removeExtraParameters().edit_card(card));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200 || response.statusCode == 201) {
      globals.myCards.remove(card);
      card = Card.fromJson(jsonDecode(response.body));
      globals.myCards.add(card);
      prefs.setStringList(
          'my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      return card;
    } else {
      throw "couldn't update a cv card";
    }
  }

  Future<void> deleteCvCard(Card card) async {
    String url = Urls.services + '/' + card.cardId.toString();
    var response = await delete(
      Uri.parse(url),
      headers: await headers(),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200 || response.statusCode == 201) {
      globals.myCards.remove(card);
      prefs.setStringList(
          'my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      print("a cv card has been deleted successfully");
    } else {
      throw "couldn't delete a card";
    }
  }

}


class RequestsServices {
  Future<List<Card>> getUserCards(String userId) async {
    Response res = await get(Uri.parse((Urls.get_user_requests+userId)),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Card> cards = [];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        card.initializeCard();
        cards.add(card);
      }
      print("got request cards for user: "+userId);
      return cards;
    }else {
      throw ("Unable to get request cards data for user: "+userId);
    }
  }
  Future<List<Card>> getMyRequests() async {
    Response res = await get(Uri.parse((Urls.requests)),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Card> cards = [];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        card.initializeCard();
        cards.add(card);
      }
      print("got my request cards ");
      return cards;
    }else {
      throw ("Unable to get my request cards");
    }
  }
  Future<List<String>> getSubjects() async {
    List<String> subject_names = [];
    Response res =
    await get(Uri.parse(Urls.requests_subjects), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subject_names.add(subject.name);
      }
      print('got requests subjects successfully');
      return subject_names;
    } else {
      throw "Unable to get requests subjects.";
    }
  }
  Future<Card> create(Card card) async {
    var response = await post(
      Uri.parse(Urls.requests),
      headers: await headers(),
      body: removeExtraParameters().card(card),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Card newCard = Card.fromJson(jsonDecode(response.body));
      return newCard;
    } else {
      throw "couldn't create a new request card";
    }
  }
  Future<Card> editCard(Card card) async {
    String url = Urls.requests + '/' + card.cardId.toString();

    var response = await put(Uri.parse(url),
        headers: await headers(), body: removeExtraParameters().edit_card(card));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("request card has been updated successfully");
      return card;
    } else {
      throw "couldn't update a request card";
    }
  }
  Future<void> deleteCard(String cardId) async {
    String url = Urls.requests + '/' + cardId;
    var response = await delete(
      Uri.parse(url),
      headers:await headers(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("the request card has been deleted successfully");
      return;
    } else {
      throw "couldn't delete the request card";
    }
  }

}


class MyStudentsServices {
  Future<MyStudentsModel> getStudents() async {
    Response res =
    await get(Uri.parse(Urls.my_students), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      print(res.body);
      MyStudentsModel myStudents = MyStudentsModel.fromJson(jsonDecode(res.body));
      print(myStudents.toJson());
      print('got my students successfully');
      return myStudents;
    } else {
      throw "Unable to get my students.";
    }
  }
  Future<MyStudentsModel> acceptStudent(String enrollId) async {
    var response = await put(Uri.parse((Urls.accept_student+enrollId)),
        headers: await headers());
    if (response.statusCode == 200 || response.statusCode == 201) {
      MyStudentsModel myStudents = await getStudents();
      print("accepted a student successfully");
      return myStudents;
    }else {
      throw "couldn't accept a student";
    }
  }
  Future<MyStudentsModel> deleteStudent(String enrollId) async {
    var response = await delete(
      Uri.parse((Urls.del_my_student +enrollId)),
      headers: await headers(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      MyStudentsModel myStudents = await getStudents();
      print("deleted a student successfully");
      return myStudents;
    }else {
      throw "couldn't delete a student from my students";
    }
  }
}

class SearchServices {
  Future<List<Tutor>> getTutors(String subject, List<String> format,
      List<String> type, String sorting) async {
    String url = searchUrl(
        Urls.get_tutors,
        subject != null ? subject : null,
        format != null && format.length == 1 ? format[0] : null,
        type != null && type.length == 1 ? type[0] : null,
        sorting != null ? sorting : null);

    Response res = await get(Uri.parse(url), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Tutor> tutors = [];
      for (int i = 0; i < obj.length; i++) {
        Tutor tutor = Tutor.fromJson(obj[i]);
        tutors.add(tutor);
      }
      globals.allTutors = tutors;
      return tutors;
    }else {
      throw "Unable to get tutors list given searching criteria";
    }
  }

  Future<List<StudentRequest>> getStudents(
      String subject, List<String> format, List<String> type) async {
    String url = searchUrl(
        Urls.get_students,
        subject != null ? subject : null,
        format != null && format.length == 1 ? format[0] : null,
        type != null && type.length == 1 ? type[0] : null,
        null);
    print(url);
    Response res = await get(Uri.parse(url),
        headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<StudentRequest> students = [];
      for (int i = 0; i < obj.length; i++) {
        StudentRequest student = StudentRequest.fromJson(obj[i]);
        students.add(student);
      }
      globals.allStudents = students;
      return students;
    }else {
      throw "Unable to get students list given certain criteria";
    }
  }
}

class CardServices {
  Future<Card> getCvCard(int cardId) async {
    Response res =
        await get(Uri.parse(Urls.get_card + cardId.toString()), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      Card card = Card.fromJson(obj);
      card.initializeCard();
      return card;
    } else {
      throw "Unable to get a card using this id data.";
    }
  }

  Future<Enrollment> createEnroll(Enrollment enroll) async {
    var response = await post(
      Uri.parse(Urls.enroll),
      headers: await headers(),
      body: removeExtraParameters().enroll(enroll),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Enrollment newEnroll = Enrollment.fromJson(jsonDecode(response.body));
      return newEnroll;
    } else {
      throw "couldn't post the data of the new enroll";
    }
  }
}

class SessionServices {
  Future<List<String>> getSubjects() async {
    List<String> subject_names = [];
    Response res =
        await get(Uri.parse(Urls.session_subjects), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subject_names.add(subject.name);
      }
      print('got session subjects successfully');
      return subject_names;
    } else {
      throw "Unable to get session subjects.";
    }
  }

  Future<List<String>> getFormats() async {
    List<String> format_names = [];
    Response res =
        await get(Uri.parse(Urls.session_formats), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      for (int i = 0; i < obj.length; i++) {
        SessionFormat format = SessionFormat.fromJson(obj[i]);
        format_names.add(format.name);
      }
      print('got session formats successfully');
      return format_names;
    } else {
      throw "Unable to get session formats.";
    }
  }

  Future<List<String>> getTypes() async {
    List<String> type_names = [];
    Response res =
        await get(Uri.parse(Urls.session_types), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      for (int i = 0; i < obj.length; i++) {
        SessionType session = SessionType.fromJson(obj[i]);
        type_names.add(session.name);
      }
      print('got session types successfully');

      return type_names;
    } else {
      throw "Unable to get session types.";
    }
  }

  Future<List<User>> getStudents(
      String subject, String format, String type) async {
    String url = searchUrl(Urls.session_students, subject, format, type, null);
    print(url);
    Response res =
        await get(Uri.parse(url), headers: await headers());
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<User> students = [];
      for (int i = 0; i < obj.length; i++) {
        User student = User.fromJson(obj[i]);
        students.add(student);
      }
      print('got session students successfully');
      return students;
    } else {
      throw "Unable to get session students.";
    }
  }

  Future<Session> create(Session session) async {
    var response = await post(
      Uri.parse(Urls.session),
      headers: await headers(),
      body: removeExtraParameters().session(session),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Session session = Session.fromJson(jsonDecode(response.body));
      print("the session has been created successfully");
      return session;
    } else {
      throw "couldn't create a new session";
    }
  }
}