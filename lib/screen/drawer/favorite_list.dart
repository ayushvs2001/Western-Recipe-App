import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:western_recipes/services/database.dart';
import 'package:western_recipes/models/user.dart';
import 'package:provider/provider.dart';
import 'package:western_recipes/shared/loading.dart';
import 'package:western_recipes/screen/home/recipe_tile.dart';



class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User_1>(context);

    return StreamBuilder<UserData>(
    stream: DatabaseService(uid: user.uid).userData,
    // so this is where the userData we used to fetch the data of the user
    builder:(context, snapshot) {
    if(snapshot.hasData) {
    UserData userData = snapshot.data;

    final favorite_list = (userData.recipes.keys).toList();

//    favorite.forEach((label) {
//       print(label);
//       print(userData.recipes[label]["source"]);
//       print(userData.recipes[label]["url"]);
//    });

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: favorite_list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                child: ListTile(
                  leading: Text(favorite_list[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        var current_favorite_map = userData.recipes;
                        current_favorite_map.remove(favorite_list[index]);
                        setState(() {

                        });
                        await DatabaseService(uid: user.uid).updateUserData(current_favorite_map);
                        print("element remove");
                      }
                   ),
                ),
                color: Colors.blueAccent,
              )
            );
          }
      ),
        ],
      ),
    );

    }
    else
    {
      return Loading();
    }
    }
    );
  }
}
