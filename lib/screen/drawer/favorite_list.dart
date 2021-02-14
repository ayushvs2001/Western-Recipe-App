import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:western_recipes/screen/home/recipe_view.dart';
import 'package:western_recipes/services/database.dart';
import 'package:western_recipes/models/user.dart';
import 'package:provider/provider.dart';
import 'package:western_recipes/shared/loading.dart';
import 'package:flutter/foundation.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

    return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: favorite_list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  if (kIsWeb) {  //kIsWeb constant return true if the application was compiled to run on web.
                    _launchURL(userData.recipes[favorite_list[index]]["url"]);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeView(
                              postUrl: userData.recipes[favorite_list[index]]["url"],  // here we call recipeView which is used to open web page
                            )
                        )
                    );
                  }
                },
              child: Card(
                margin: EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                child: ListTile(
                  title: Text(favorite_list[index]),
                  trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.black,),
                      onPressed: () async {
                        var current_favorite_map = userData.recipes;
                        current_favorite_map.remove(favorite_list[index]);
                        await DatabaseService(uid: user.uid).updateUserData(current_favorite_map);
                      }
                   ),
                  subtitle: Text(userData.recipes[favorite_list[index]]["source"]),
                ),
                color: Colors.grey[300],

              )
            );
          }
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
