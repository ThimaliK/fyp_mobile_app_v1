import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/recipe.dart';
import 'package:fyp_mobile_app_v1/recipe_collection.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Landing Page'),
    ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[


                ElevatedButton(
                  child: Text('Log In'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign_in');
                  },
                ),

                ElevatedButton(
                  child: Text('Create Account'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign_up');
                  },
                )
              ],
            )
        )
    );


  }

}



