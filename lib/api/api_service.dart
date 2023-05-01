import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'package:fyp_mobile_app_v1/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {

  String baseUrl = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com";

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async{

    String url = "$baseUrl/sign_in";
    final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
        'email': loginRequestModel.email,
        'password': loginRequestModel.password,

      }),
    );

    if(response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      prefs.setString("username", LoginResponseModel.fromJson(json.decode(response.body)).username);
      prefs.setString("email", LoginResponseModel.fromJson(json.decode(response.body)).email);
      prefs.setString("bmi", LoginResponseModel.fromJson(json.decode(response.body)).bmi);
    }

    if(response.statusCode == 200 || response.statusCode == 401) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load data");
    }

  }

  Future<LoginResponseModel> loadLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? bmi = prefs.getString('bmi');

    return LoginResponseModel(username as String, bmi as String, email as String);
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

  }

  Future<SignupResponseModel> register(SignupRequestModel signupRequestModel) async{

    String url = "$baseUrl/sign_up";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': signupRequestModel.username,
        'email': signupRequestModel.email,
        'password': signupRequestModel.password,
        'country': signupRequestModel.country,
        'birth_date': signupRequestModel.birthDate,
        'food_preferences': signupRequestModel.foodPreferences,
        'weight': signupRequestModel.weight,
        'height': signupRequestModel.height,
        'fit_bit_id': signupRequestModel.fitbitUserID

      }),
    );


    if(response.statusCode == 200 || response.statusCode == 403) {

      return SignupResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("failed to load data");
    }

  }

  Future<GetRecipesResponseModel> foodRecognition(List<File> images) async{

      String url = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com/get_recipes_list";

      if(images.isNotEmpty) {

        Dio dio = Dio();

        dio.options.baseUrl = baseUrl;
        dio.options.connectTimeout = const Duration(seconds: 20);
        dio.options.receiveTimeout = const Duration(seconds: 20);

        var formData = FormData();
        for (var file in images) {
          formData.files.addAll([
            MapEntry("files[]", await MultipartFile.fromFile(file.path)),
          ]);
        }

        var response = await dio.post(url, data: formData);

        if (response.statusCode == 200) {

          var x = jsonEncode(response.data);
          var res = GetRecipesResponseModel.fromJson(json.decode(x.toString()));
          return res;

        } else {
          throw Exception("failed");
        }

      } else {
        throw Exception("no images uploaded");
      }


    }



  Future<GetCustomisedRecipesResponseModel> getCustomisedRecipes(String email) async{

    String url = '$baseUrl/get_customised_recipes_list';

      Dio dio = Dio();
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = const Duration(seconds: 20);
      dio.options.receiveTimeout = const Duration(seconds: 20);

      var formData = FormData();
      formData.fields.add(MapEntry("email", email));
      var response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {

        var x = jsonEncode(response.data);
        var res = GetCustomisedRecipesResponseModel.fromJson(json.decode(x.toString()));
        return res;

      } else {
        throw Exception("failed");
      }
  }




  Future<List<FoodResponseModel>> getBestMatchedRecipes() async{

    await Future.delayed(const Duration(seconds: 10));

    String url = "$baseUrl/get_best_matched_recipes";
    final response = await http.post(Uri.parse(url));

    if(response.statusCode == 200) {
      Iterable l = json.decode(response.body);  //
      List<FoodResponseModel> recipes = List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));
      return recipes;
    } else {
      throw Exception("failed to load data");
    }

  }


  Future<String> customisedRecipes(List<File> images, String email) async{

    String url = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com/recognise_ingredients_for_customisation";

    if(images.isNotEmpty) {
      Dio dio = Dio(); // with default Options
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = const Duration(seconds: 20); //5s
      dio.options.receiveTimeout = const Duration(seconds: 20);

      var formData = FormData();
      for (var file in images) {
        formData.files.addAll([
          MapEntry("files[]", await MultipartFile.fromFile(file.path)),
        ]);
      }

      formData.fields.add(MapEntry("email", email));
      var response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {

        return response.data.toString();

      } else {

        return "failed";
      }

    } else {
      return "no images";
    }


  }


  Future<List<FoodResponseModel>> getBestMatchedCustomisedRecipes() async{

    String url = "$baseUrl/get_best_matched_customised_recipes";
    final response = await http.post(Uri.parse(url));

    if(response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<FoodResponseModel> recipes = List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));
      return recipes;
    } else {
      throw Exception("failed to load data");
    }

  }


}