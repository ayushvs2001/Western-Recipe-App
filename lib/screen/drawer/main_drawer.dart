import 'package:flutter/material.dart';
import 'package:western_recipes/screen/drawer/favorite_list.dart';
import 'package:western_recipes/services/auth.dart';
import 'package:western_recipes/shared/constants.dart';

const sign1 = Icon(Icons.add,color:Colors.black,);
const sign2 = Icon(Icons.remove,color:Colors.black,);

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  final AuthServices _auth = AuthServices();  // this _auth variable use for logout


  bool history_sign = true;

  Widget _showSettingsPanel(){
   print("Button click");
   history_sign = !history_sign;
   print(history_sign);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
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
                FavoriteList(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
