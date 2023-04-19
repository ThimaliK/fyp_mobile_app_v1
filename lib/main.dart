import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/landing_page.dart';
import 'dart:io';
import 'package:fyp_mobile_app_v1/loading.dart';
import 'package:fyp_mobile_app_v1/home.dart';
import 'package:fyp_mobile_app_v1/camera_input.dart';
import 'package:fyp_mobile_app_v1/recipe_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fyp_mobile_app_v1/sign_in.dart';
import 'package:fyp_mobile_app_v1/sign_up.dart';

// void main() => runApp(MaterialApp(
//   initialRoute: '/',
//   routes: {
//     '/': (context) => const Home(),
//     '/home': (context) => const Home(),
//     '/camera_input': (context) => const CameraInput(),
//     '/recipe_list': (context) => const RecipeList(),
//   },
//
// ));

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
      },

      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('es'),
        const Locale('de'),
        const Locale('fr'),
        const Locale('el'),
        const Locale('et'),
        const Locale('nb'),
        const Locale('nn'),
        const Locale('pl'),
        const Locale('pt'),
        const Locale('ru'),
        const Locale('hi'),
        const Locale('ne'),
        const Locale('uk'),
        const Locale('hr'),
        const Locale('tr'),
        const Locale('lv'),
        const Locale('lt'),
        const Locale('ku'),
        const Locale('nl'),
        const Locale('it'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

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
