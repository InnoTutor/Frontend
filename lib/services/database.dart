import 'dart:convert';

import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/card.dart';
import 'package:inno_tutor/models/enrollment.dart';
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

class Services{
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Authorization" :"Bearer " + globals.user.token
  };

  Future<Card> postCvCard(Card card) async {
    final data = removeExtraParametersCard(card);
    var response = await post(Uri.parse(Urls.my_cvcard),
        headers: headers,
        body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Card newCard = Card.fromJson(jsonDecode(response.body));
      newCard.initializeCard();
      globals.myCards.add(newCard);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      return newCard;
    }else if (response.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await postCvCard(card);
    }else{
      throw"couldn't post the data of createCVCard";
    }
  }
  Future<List<Card>> getCvCards() async{
    Response res = await get(Uri.parse(Urls.my_cvcard),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {

      final obj = jsonDecode(res.body);
      List<Card>cards=[];
      for (int i = 0; i < obj.length; i++) {
        Card card = Card.fromJson(obj[i]);
        card.initializeCard();
        cards.add(card);
      }
      return cards;
    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getCvCards();
    }else {
      throw "Unable to get cards data.";
    }
  }
  Future<Card> getCvCard(String cardId) async{
    Response res = await get(Uri.parse(Urls.get_card+cardId),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      Card card = Card.fromJson(obj);
      card.initializeCard();
      return card;
    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getCvCard(cardId);
    }else {
      throw "Unable to get a card using this id data.";
    }
  }

  Future<void> updateCvCard(Card card)async{
    String url = Urls.my_cvcard + '/'+card.cardId.toString();

    var response = await put(Uri.parse(url),
        headers: headers,
        body: jsonEncode(card.toJson())
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200 || response.statusCode==201) {
      globals.myCards.remove(card);
      card = Card.fromJson(jsonDecode(response.body));
      globals.myCards.add(card);
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
    }else if (response.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await updateCvCard(card);
    }else{
      throw "couldn't update a cv card";
    }

  }

  Future<void> deleteCvCard(Card card)async{
    String url = Urls.my_cvcard + '/'+card.cardId.toString();
    var response = await delete(Uri.parse(url),
      headers: headers,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200 || response.statusCode==201) {
      globals.myCards.remove(card);
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
      print(response.body);
    }else if (response.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await deleteCvCard(card);
    }else {
      throw'couldnt delete a card';
    }
  }

  Future<Enrollment> postEnroll(Enrollment enroll) async {
    final data = removeExtraParametersEnroll(enroll);
    var response = await post(Uri.parse(Urls.enroll),
        headers: headers,
        body: data,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Enrollment newEnroll = Enrollment.fromJson(jsonDecode(response.body));
     return newEnroll;
    }else if (response.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await postEnroll(enroll);
    }else{
      throw "couldn't post the data of the new enroll";
    }
  }

  // create request card
  Future<Card> createRequestCard(Card card) async {
      final data = removeExtraParametersCard(card);
      var response = await post(Uri.parse(Urls.request_card),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Card newCard = Card.fromJson(jsonDecode(response.body));
        newCard.initializeCard();
        globals.myCards.add(newCard);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));
        return newCard;
      }else if (response.statusCode == 403){
        await AuthService().accessSecureResource(await AuthService().extractToken());
        return await createRequestCard(card);
      }else{
        print("couldn't post the data of createCVCard");
        return card;
      }

  }


  Future<List<String>> getSubjects() async{
    List<String>subject_names=[];
    print("I'm in subject names helloooozz ");

    Response res = await get(Uri.parse(Urls.subjects),headers: headers);
    if(res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<Subject> subjects =  [];
      for (int i = 0; i < obj.length; i++) {
        Subject subject = Subject.fromJson(obj[i]);
        subjects.add(subject);

        subject_names.add(subject.name);
      }
      return subject_names;

    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getSubjects();
    } else {
      throw "Unable to get subjects.";
    }
  }
  Future<List<String>> getSessionFormat() async{
    List<String>format_names=[];
    print("I'm in format names helloooozz ");

    Response res = await get(Uri.parse(Urls.formats),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<SessionFormat> formats =  [];
      for (int i = 0; i < obj.length; i++) {
        SessionFormat format = SessionFormat.fromJson(obj[i]);
        formats.add(format);

        format_names.add(format.name);
      }
      return format_names;

    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getSessionFormat();
    }else {
      throw "Unable to get subjects.";
    }
  }
  Future<List<String>> getSessionType() async{
    List<String>type_names=[];
    print("I'm in sessiontype names helloooozz ");

    Response res = await get(Uri.parse(Urls.types),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final obj = jsonDecode(res.body);
      List<SessionType> sessions =  [];
      for (int i = 0; i < obj.length; i++) {
        SessionType session = SessionType.fromJson(obj[i]);
        sessions.add(session);

        type_names.add(session.name);
      }
      return type_names;

    }else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getSessionType();
    } else {
      throw "Unable to get subjects.";
    }
  }

  Future<List<Tutor>> getTutors(String subject, String format, String type,String sorting) async {
    String url = searchUrl(Urls.get_tutors, subject, format, type, sorting);
    print(url);
    Response res = await get(Uri.parse(url),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {

      final obj = jsonDecode(res.body);
      List<Tutor>tutors=[];
      for (int i = 0; i < obj.length; i++) {
        Tutor tutor = Tutor.fromJson(obj[i]);
        tutors.add(tutor);
      }
      return tutors;
    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getTutors(subject, format , type,sorting);
    }else {
      throw "Unable to get tutors list.";
    }
  }
  Future<List<StudentRequest>> getStudents(String subject , String format , String type ) async {
    String url = searchUrl(Urls.get_students, subject, format, type, null);
    print(url);
    Response res = await get(Uri.parse(Urls.get_students),headers: headers);
    if (res.statusCode == 200 || res.statusCode == 201) {

      final obj = jsonDecode(res.body);
      List<StudentRequest>students=[];
      for (int i = 0; i < obj.length; i++) {
        StudentRequest student = StudentRequest.fromJson(obj[i]);
        students.add(student);
      }
      return students;
    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getStudents(subject,format,type);
    }else {
      throw "Unable to get students list.";
    }
  }


  Future<User>getUser(String userId) async{
    Response res = await get(Uri.parse((Urls.get_user+userId)) , headers:headers);
    if (res.statusCode == 200 || res.statusCode == 201) {

      final obj = jsonDecode(res.body);
      User user;
      for (int i = 0; i < obj.length; i++) {
        user = User.fromJson(obj[i]);
      }
      return user;
    } else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await getUser(userId);
    }else {
      print( "Unable to get user data.");
      return null;
    }
  }
  Future<User>getProfile() async{
    return await getUser(globals.user.userId.toString());
  }
  Future<void>updateProfile(User user) async{
    Response res = await put(
      Uri.parse((Urls.profile)),
      headers:headers,
      body: jsonEncode(user.toJson()));
    if (res.statusCode == 200 || res.statusCode == 201) {
      globals.user = user;
      print('user profile has been updated successfully');
    }  else if (res.statusCode == 403){
      await AuthService().accessSecureResource(await AuthService().extractToken());
      return await updateProfile(user);
    }else {
      throw "Unable to get user data.";
    }
  }
}