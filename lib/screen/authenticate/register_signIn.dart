import 'package:flutter/material.dart';
import 'package:western_recipes/services/auth.dart';
import 'package:western_recipes/shared/constants.dart';
import 'package:western_recipes/shared/loading.dart';

class Register_SignIn extends StatefulWidget {
  @override
  _Register_SignInState createState() => _Register_SignInState();
}

class _Register_SignInState extends State<Register_SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>(); // this is used to identify our form and associated with global form key
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text("Explore Your Favourite Recipes"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/burger.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/30,
                               horizontal: MediaQuery.of(context).size.width/25),
        child: Form(
          key: _formKey,  // here we associated form with formkey
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/50),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val.isEmpty ? 'Enter an Email': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,  // this is password field and obscureText proper protect password from revealing
                validator: (val) => val.length < 6 ? 'Enter an password more than 6 char': null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height:MediaQuery.of(context).size.height/50),
              Column(
                children: [
                  SizedBox(height:20.0),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width/2,
                    height:MediaQuery.of(context).size.height/15,
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    child: RaisedButton(
                      color: Colors.blueAccent[100],
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) // return true or false depending upon the form is correct or not
                            {
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null){
                            setState(() {
                              error = "please supply a valid email";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height:MediaQuery.of(context).size.height/35),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/15,
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)
                    ),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) // return true or false depending upon the form is correct or not
                            {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null){
                            setState(()
                            {
                              error = "credential failed";
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.pinkAccent[100],
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Colors.indigo[900], fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                error,
                style: TextStyle(color: Colors.cyan, fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

