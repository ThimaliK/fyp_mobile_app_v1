import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/customised_recipe_list.dart';
import 'package:fyp_mobile_app_v1/individual_recipe.dart';
import 'package:fyp_mobile_app_v1/landing_page.dart';
import 'dart:io';
import 'package:fyp_mobile_app_v1/home.dart';
import 'package:fyp_mobile_app_v1/camera_input.dart';
import 'package:fyp_mobile_app_v1/recipe_list.dart';
import 'package:fyp_mobile_app_v1/sign_in.dart';
import 'package:fyp_mobile_app_v1/sign_up.dart';

void main() {
    runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/sign_up': (context) => const SignUp(),
        '/sign_in': (context) => const SignIn(),
        '/home': (context) => const Home(),
        '/camera_input': (context) => const CameraInput(),
        '/recipe_list': (context) => const RecipeList(),
        '/individual_recipe': (context) => const IndividualRecipe(),
        '/customised_recipe_list': (context) => const CustomisedRecipeList(),
      },
//

    ));

    HttpOverrides.global = MyHttpOverrides();
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
