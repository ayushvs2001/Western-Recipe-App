import 'package:flutter/material.dart';
import 'package:western_recipes/screen/drawer/favorite_list.dart';
import 'package:western_recipes/services/auth.dart';

const sign1 = Icon(Icons.add,color:Colors.black,);
const sign2 = Icon(Icons.remove,color:Colors.black,);

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  final AuthServices _auth = AuthServices();  // this _auth variable use for logout

  bool history_sign = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          DrawerHeader(
              child: Text("Settings", style: TextStyle(
                fontSize: 30
              ),
              ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: FlatButton.icon(
                    minWidth: 250,
                    height: 40,
                    icon: Icon(Icons.collections_bookmark),
                    label: Text("Favourite", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    ),
                    onPressed: () {
                      setState(() {
                        history_sign = !history_sign;
                      });
                    },
                    color: Colors.green[300],
                  ),
                  trailing: history_sign ? sign1 : sign2,
                ),
                history_sign ? SizedBox():FavoriteList(),
                ListTile(
                  leading: FlatButton.icon(
                    minWidth: 250,
                    height: 40,
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Log out", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                    color: Colors.pinkAccent,
                  ),
                ),
                ListTile(
                  leading: FlatButton.icon(
                    minWidth: 250,
                    height: 40,
                    onPressed: () async {
                      Navigator.of(context).pop(true);  // back button
                    },
                    icon: Icon(Icons.home),
                    label: Text("Home", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),),
                    color: Colors.cyanAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
