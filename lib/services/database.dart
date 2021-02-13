import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:western_recipes/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('user_data'); // collection name

  Future updateUserData(var favorite) async { // call twice at time of regestering and sign in

    return await dataCollection.doc(uid).set({
           "recipes" : favorite,
    });
  }


  // userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      recipes: snapshot.data()["recipes"],
    );
  }

// get user doc stream
  Stream<UserData> get userData{
    return dataCollection.doc(uid).snapshots().map(_userDataFromSnapShot);
  }

}