import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:inno_tutor/models/user.dart' as user2;

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String name;
  String imageUrl;
  bool authSignedIn;
  String uid;
  String userEmail;

  // todo
  // change it with the meant uri
  String url = 'http://192.168.120.129:8080/api/employees';
  // //Handles Auth
  // handleAuth() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           // todo
  //           // return Home();
  //         } else {
  //           //todo
  //           // return Login();
  //         }
  //       });
  // }

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
    Response response = await get(Uri.parse(url), headers: headers);
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "Could not get input from server";
    }
    return response.body.toString();
  }
  void signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('auth', false);

    uid = null;
    name = null;
    userEmail = null;
    imageUrl = null;

    print("User signed out of Google account");
  }
  //SignIn
  signInWithGoogle() async {

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
      // Checking if email and name is null
      assert(user.uid != null);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('auth', true);
      return 'Google sign in successful, User UID: ${user.uid}';
    }
    return null;

  }
  Future<user2.User> getUserData() async {

    final User currentUser = _auth.currentUser;


      uid = currentUser.uid;
      name = currentUser.displayName;
      userEmail = currentUser.email;
      imageUrl = currentUser.photoURL;

      assert(!currentUser.isAnonymous);
      assert(await currentUser.getIdToken() != null);
      return user2.User(uid, name, userEmail, imageUrl);

    }


}