import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:western_recipes/models/user.dart';
import 'database.dart';


class AuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // underscore means the private property which we only use in this file, not in outside of file
  // this statement used to create instance of Firebase class

  //create user object based on FireBasedUser
  User_1 _userFromFirebaseUser(User user) {
    return user != null ? User_1(uid: user.uid) : null;  // User_1 has his own different class
  }

  // auth change user stream
  Stream<User_1> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  
//sign with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // it is built in firebase method to register
      User user = result.user;
      return _userFromFirebaseUser(user); // if this is success, return uid
    }
    catch (e) {
      print("error during the sign in");
      print(e.toString());
      return null;
    }
  }


// register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // it is built in firebase method to register
      User user = result.user;

//      var recipes = {"label":"this is label","source": "this is source", "url":"this is url"};
//      await DatabaseService(uid: user.uid).updateUserData(recipes);

      return _userFromFirebaseUser(user); // if this is success, return uid
    }
    catch (e) {
      print("error during the registering the email and password");
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {  // tut 9 about signout
    try{
      return await _auth.signOut();
    }
    catch(e) {
      print("error in signout");
      print(e.toString());
      return null;

    }
  }
}