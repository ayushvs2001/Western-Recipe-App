import 'package:flutter/material.dart';
import 'recipe_view.dart';
import 'package:western_recipes/services/database.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:western_recipes/models/user.dart';
import 'package:western_recipes/shared/loading.dart';
import 'package:provider/provider.dart';


const favorite_icon_pink = Colors.pink;
const favorite_icon_black = Colors.black;

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  bool color_favorite = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_1>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
    // so this is where the userData we used to fetch the data of the user
    builder: (context, snapshot) {
    if(snapshot.hasData) {
    UserData userData = snapshot.data;

    // this update the current widget if the item delete from the favorite list
    color_favorite = userData.recipes.keys.contains(widget.title);

    return Wrap(
        children: <Widget>[
          GestureDetector( // it it used to drive us at web pages
            onTap: () {
              if (kIsWeb) {
                _launchURL(widget.url);
              } else {
                print(widget.url + " this is what we are going to see");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeView(
                          postUrl: widget.url,  // here we call recipeView which is used to open web page
                        )
                    )
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(color: Colors.black, spreadRadius: 3),
                  ]
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: widget.imgUrl !=null ? Image.network(
                      widget.imgUrl,
                    ) : SizedBox(),
                  ),
                  Container(
                    width: 240,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        gradient: LinearGradient(
                            colors: [Colors.white30, Colors.white],
                            begin: FractionalOffset.centerRight,
                            end: FractionalOffset.centerLeft)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Overpass'),
                          ),
                          Text(
                            widget.desc,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'OverpassRegular'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 75,
                    width: 165,
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        icon: Icon(Icons.favorite),
                        color: (color_favorite = userData.recipes.keys.contains(widget.title) || color_favorite) ? favorite_icon_pink : favorite_icon_black,
                        onPressed: () async {
                          setState(() {
                            color_favorite = !color_favorite;
                          }
                          );
                            var favorite = new Map();
                            favorite = userData.recipes;
                            if (color_favorite) { // if colour_favorite is true, then item is added
                              print("element added");
                              favorite[widget.title] =  {"source":widget.desc, 'url':widget.url};
                              await DatabaseService(uid: user.uid).updateUserData(favorite);
                            }
                            else{
                              favorite.remove(widget.title);
                              await DatabaseService(uid: user.uid).updateUserData(favorite);
                              print("element remove");
                          }
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
