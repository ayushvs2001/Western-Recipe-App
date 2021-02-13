import 'package:flutter/material.dart';
import 'package:western_recipes/services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recipe.dart';
import 'package:western_recipes/screen/drawer/main_drawer.dart';
import 'recipe_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();  // this _auth variable use for logout

  List<RecipeModel> recipies = new List();
  String ingridients;
  bool _loading = false;
  String query = "";
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Western Recipes App"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/coffee_bg.png"),
                  fit: BoxFit.cover,
                ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical:30 , horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "What will you cook today?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Overpass'),
                            decoration: InputDecoration(
                              hintText: "Enter Food Name/Ingridients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.5),
                                  fontFamily: 'Overpass'),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  _loading = true;
                                });
                                print(textEditingController.text.toString());
                                recipies = new List();

                                String url =
                                    "https://api.edamam.com/search?q=${textEditingController.text.toString()}&app_id=142449c4&app_key=db574863b772744c78208a7c36ad8307";

                                var response = await http.get(url);
                                print(" $response this is response");
                                Map<String, dynamic> jsonData = jsonDecode(response.body);
                                print("this is json Data $jsonData");
                                jsonData["hits"].forEach((element) {
                                  print(element.toString());
                                  RecipeModel recipeModel = new RecipeModel();
                                  recipeModel = RecipeModel.fromMap(element['recipe']);
                                  recipies.add(recipeModel);
                                  print(recipeModel.url);
                                });
                                setState(() {
                                  _loading = false;
                                });
                                print("doing it");
                              } else {
                                print("not doing it");
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffA2834D),
                                        const Color(0xffBC9A5F)
                                      ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Colors.white
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: GridView( // it is used to store many item at a time, and scroll over them
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: List.generate(recipies.length, (index) {
                          return GridTile(
                              child: RecipieTile(
                                title: recipies[index].label,
                                imgUrl: recipies[index].image,
                                desc: recipies[index].source,
                                url: recipies[index].url,
                              ));
                        })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      );
  }
}

