import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  //  a way to produce future objects and to complete them later with value or error.
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  String finalUrl ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }
// https is more secure than http.https made information encrypted while http do nothing.
  // https work on transport layer, while http work on the application layer
    // https use port 443 and http use port 80
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30,
                    right: 24,
                    left: 24,
                    bottom:0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xff213A50),
                          const Color(0xff071930)
                        ],
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft)
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 30,
                width: MediaQuery.of(context).size.width,
                child: WebView(
                  onPageFinished: (val) {
                    print("$val page finished");
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: finalUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      _controller.complete(webViewController);
                    }
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}