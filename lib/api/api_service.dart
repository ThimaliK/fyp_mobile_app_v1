import 'dart:io';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'package:fyp_mobile_app_v1/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/signup_model.dart';

class APIService {

  String baseUrl = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com";

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async{
    //String url = 'http://10.0.2.2:5000/sign_in';

    String url = "$baseUrl/sign_in";

    print('in future login');

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

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200 || response.statusCode == 401) {
      print('status code: ${response.statusCode}');
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load data");
    }

  }

  Future<LoginResponseModel> register(SignupRequestModel signupRequestModel) async{

    //String url = 'http://10.0.2.2:5000/sign_up';

    String url = "$baseUrl/sign_up";

    print('in future sign up');

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
        'fit_bit_id': signupRequestModel.fitbitUserID

      }),
    );

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200 || response.statusCode == 409) {
      print('status code: ${response.statusCode}');
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("failed to load data");
    }

  }

  Future<String> foodRecognition(List<File> images) async{

      //String url = 'http://10.0.2.2:5000/recognise_ingredients';

      String url = "$baseUrl/recognise_ingredients";

      print('in future recognise_ingredients');

      var request = http.MultipartRequest('POST', Uri.parse(url));

      print('1------------------------------------');

      if (images.isNotEmpty) {

        for (var i = 0; i < images.length; i++) {
          request.files.add(http.MultipartFile('files[]',
              File(images[i].path).readAsBytes().asStream(), File(images[i].path).lengthSync(),
              filename: images[i].path));
        }

        print('2------------------------------------');

        var response = await request.send();

        print('3------------------------------------');

        var responsed = await response.stream.bytesToString(utf8);

        if(response.statusCode == 200) {
          print('status code: ${response.statusCode}');

          print(responsed);

          return responsed;

        } else {
          throw Exception("failed to load data");
        }


      }
      return "failed";



  }

  Future<List<FoodResponseModel>> getBestMatchedRecipes() async{

    //String url = 'http://10.0.2.2:5000/get_best_matched_recipes';

    String url = "$baseUrl/get_best_matched_recipes";

    print('in future getBestMatchedRecipes');

    final response = await http.post(Uri.parse(url));

    print('A--------------------------------------------------');

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200) {
      print('status code: ${response.statusCode}');

      Iterable l = json.decode(response.body);

      print(response.body);

      print('iterable done...');

      print('LENGTH: ${l.length}');

      List<FoodResponseModel> recipes = List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));

      print('recipe list done');

      return recipes;
    } else {
      throw Exception("failed to load data");
    }

  }


}