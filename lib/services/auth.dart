import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:inno_tutor/constants/strings.dart';
import 'package:inno_tutor/models/user.dart' as user2;
import 'package:inno_tutor/globals.dart' as globals;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String name;
  String imageUrl;
  bool authSignedIn;
  String uid;
  String userEmail;
  Future<String> extractTokenAndAccessSecureResource() async {
    var token = await extractToken();
    return await accessSecureResource(token);
  }

  Future<String> extractToken() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = await firebaseAuth.currentUser;
    String token = (await user.getIdToken());
    return token;
  }

  Future<String> accessSecureResource(token) async {
    //todo
    // is it needed to get changed?
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization" :"Bearer " + token
    };
    print("Token "+ token);
    Response response = await get(Uri.parse(Urls.url), headers: headers);
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "Could not get input from server";
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

    print("User signed out of Google account");
  }
  //SignIn
  Future<User> signInWithGoogle() async {

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
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;
      final User currentUser = _auth.currentUser;
      globals.user = user2.User(uid , name, userEmail,imageUrl);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('auth', true);
      return user;
    }
    return null;

  }
  Future<user2.User> getUserData() async {

    final User currentUser = await _auth.currentUser;
    if(currentUser == null)
      return null;

    uid =  currentUser.uid;
    name =  currentUser.displayName;
    userEmail =  currentUser.email;
    imageUrl =  currentUser.photoURL;

    return user2.User(uid, name, userEmail, imageUrl);

    }


}