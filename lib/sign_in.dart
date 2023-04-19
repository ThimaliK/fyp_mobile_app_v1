import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/recipe.dart';
import 'package:fyp_mobile_app_v1/recipe_collection.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Login to your Account'),
    ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Log In'),
                  onPressed: (){},
                )
              ],
            )
        )
    );


  }

}



