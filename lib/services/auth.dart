import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/user.dart' as user2;
import 'package:inno_tutor/globals.dart' as globals;
import 'package:inno_tutor/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String name;
  String imageUrl;
  bool authSignedIn;
  String uid;
  String userEmail;

  Future<String> extractToken() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = await firebaseAuth.currentUser;
    if(user == null)return null;
    String token = (await user.getIdToken());
    return token;
  }

  Future<void> accessSecureResource(token) async {
    print("Token "+ token);
    var response = await get(Uri.parse(Urls.profile),
        headers: <String, String> {
        "Content-type": "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization" :"Bearer " + token
      },
    );

    int statusCode = response.statusCode;
    if(statusCode != 200 && statusCode != 201){
      return "Could not get input to server";
    }else{
      print('in access secure resource and printing response body');
      print(response.body);
      globals.user = user2.User.fromJson(jsonDecode(response.body));
    }
    return response.body.toString();
  }
  void signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    uid = null;
    name = null;
    userEmail = null;
    imageUrl = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    globals.user=null;
    globals.myCards=null;
    prefs.remove('user');
    prefs.remove('my_cards');
    print("User signed out of Google account");
  }
  //SignIn
  Future<void> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User user = userCredential.user;

    if (user != null) {
      await accessSecureResource(await extractToken());
      globals.myCards = await Services().getMyCvCards();
      globals.formats = await SessionServices().getFormats();
      globals.types = await SessionServices().getTypes();
      print('user data has been posted to the server successfully');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(globals.user));
      prefs.setStringList('my_cards', (globals.myCards.map((e) => json.encode(e)).toList()));

      await MyStudentsServices().getStudents();

    }
    return null;

  }
  // Future<user2.User> getUserData() async {
  //
  //   final User currentUser = await _auth.currentUser;
  //   if(currentUser == null)
  //     return null;
  //
  //   uid =  currentUser.uid;
  //   name =  currentUser.displayName;
  //   userEmail =  currentUser.email;
  //   imageUrl =  currentUser.photoURL;
  //
  //   return globals.user;
  //
  //   }


}