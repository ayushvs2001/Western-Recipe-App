import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:western_recipes/models/user.dart';
import 'package:western_recipes/screen/wrapper.dart';
import 'package:western_recipes/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_1>.value(  // provider package is use for state management
    value: AuthServices().user,  // stream we want to listean
    child: MaterialApp(
    home: Wrapper(),
    ),
    );
}
}