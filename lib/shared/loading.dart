import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/burger.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              color: Colors.brown[100],
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              )
          ),
        );
  }
}
