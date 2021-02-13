import 'package:flutter/material.dart';

class User_1 {
  final String uid;
  User_1({ this.uid }); // constructor
}

class UserData{

  final String uid;
  var recipes = new Map();

  UserData({ this.uid, this.recipes });

}