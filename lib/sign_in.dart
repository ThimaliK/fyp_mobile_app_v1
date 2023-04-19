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


Future<http.Response> signIn(String email, String password) async {



    print("1-------------------------");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/sign_in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'username': email,
        'password': password,

      }),
    );

    print("2-------------------------");

    print("status code${response.statusCode}");

    print(response.body);

    return response;




}

class _SignInState extends State<SignIn> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Login to your Account'),
    ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                    controller: passwordController,
                  ),

                ),
                ElevatedButton(
                  child: const Text('Log In'),
                  onPressed: (){
                    String email = emailController.text;
                    String password = passwordController.text;
                    signIn(email, password);

                    print("DONE!!!!!!");
                  },
                )
              ],
            )
        )
    );


  }

}



