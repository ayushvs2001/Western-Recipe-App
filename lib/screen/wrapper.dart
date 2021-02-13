import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:western_recipes/models/user.dart';
import 'package:western_recipes/screen/home/home.dart';
import 'package:western_recipes/screen/authenticate/register_signIn.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User_1>(context);
    // print(user);
    // it give null at first then we get ""Instance of 'User_1'""  (8 provider package)

    // return either home or authenticate window depend upon condition
    if (user == null)
    {
      return Register_SignIn();
    }
    else
    {
      return Home();
    }
  }
}