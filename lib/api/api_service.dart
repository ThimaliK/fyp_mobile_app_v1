import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'package:fyp_mobile_app_v1/models/login_model.dart';
import 'package:fyp_mobile_app_v1/models/user_model.dart';
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

  Future<SignupResponseModel> register(SignupRequestModel signupRequestModel) async{

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
        'weight': signupRequestModel.weight,
        'height': signupRequestModel.height,
        'fit_bit_id': signupRequestModel.fitbitUserID

      }),
    );

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200 || response.statusCode == 409) {
      print('status code: ${response.statusCode}');
      return SignupResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception("failed to load data");
    }

  }

  Future<GetRecipesResponseModel> foodRecognition(List<File> images) async{

      // //String url = 'http://10.0.2.2:5000/recognise_ingredients';
      //
      String url = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com/get_recipes_list";
      //
      // print('in future recognise_ingredients');
      //
      // var request = http.MultipartRequest('POST', Uri.parse(url));
      //
      // print('1------------------------------------');
      //
      // if (images.isNotEmpty) {
      //
      //   for (var i = 0; i < images.length; i++) {
      //     request.files.add(http.MultipartFile('files[]',
      //         File(images[i].path).readAsBytes().asStream(), File(images[i].path).lengthSync(),
      //         filename: images[i].path));
      //   }
      //
      //   print('2------------------------------------');
      //
      //   var response = await request.send();
      //
      //   print('3------------------------------------');
      //
      //   var responsed = await response.stream.bytesToString(utf8);
      //
      //   print("response "+responsed.toString());
      //   print("code "+response.statusCode.toString());
      //
      //   if(response.statusCode == 200) {
      //     print('status code: ${response.statusCode}');
      //
      //     print(responsed);
      //
      //     return responsed;
      //
      //   } else {
      //     throw Exception("failed to load data");
      //   }
      //
      //
      // }
      // return "failed";

      if(images.isNotEmpty) {

        print("A------------------------------------");

        Dio dio = new Dio(); // with default Options

        // Set default configs
        dio.options.baseUrl = baseUrl;
        dio.options.connectTimeout = Duration(seconds: 20); //5s
        dio.options.receiveTimeout = Duration(seconds: 20);



        print("B------------------------------------");


        var formData = FormData();
        for (var file in images) {
          formData.files.addAll([
            MapEntry("files[]", await MultipartFile.fromFile(file.path)),
          ]);

          print("file size${file.lengthSync()}");
        }

        print("C------------------------------------");

        var response = await dio.post(url, data: formData);

        print("D------------------------------------");

        if (response.statusCode == 200) {
          //apiResponse.onSuccess(response.toString(), eventType);

          print("E------------------------------------");

          print("Image Uploaded");

          var x = jsonEncode(response.data);

          print(x.toString());

          //List<FoodResponseModel> recipes = jsonDecode(x.toString());

          //print(jsonDecode(response.data));

          // return (response.data as List)
          //     .map((x) => FoodResponseModel.fromJson(x))
          //     .toList();

          // Iterable l = json.decode(response.data.toString());
          //
          // print('LENGTH: ${l.length}');
          //
          //
          // List<FoodResponseModel> recipes =
          // List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));

          // return (response.data as List)
          //     .map((x) => FoodResponseModel.fromJson(x))
          //     .toList();

          //return recipes;

          print("AAA");

          //print(data.first["name"]);
          //Iterable l = jsonDecode(response.data);

          print("BBB");

          //List<FoodResponseModel> recipes = List<FoodResponseModel>.from(response.data.map((e) => FoodResponseModel.fromJson(e)));

          //return recipes;

          //GetRecipesResponseModel getRecipesResponseModel = json.decode(x.toString());

          //Iterable l = json.decode(x.toString());

         //  GetRecipesResponseModel getRecipesResponseModel =
         // GetRecipesResponseModel.from(x.toString().map((e) => GetRecipesResponseModel.fromJson(e)));

          print("n1");

          var res = GetRecipesResponseModel.fromJson(json.decode(x.toString()));

          print("n2");

          return res;



          //return getRecipesResponseModel;

        } else {
          //apiResponse.onError('Failed to load post');

          print(response.data.toString());

          print("Upload Failed");

          throw Exception("failed");

        }

      } else {
        throw Exception("no images uploaded");
      }


    }



  Future<GetCustomisedRecipesResponseModel> getCustomisedRecipes(List<File> images, String email) async{

    // //String url = 'http://10.0.2.2:5000/recognise_ingredients';
    //
    String url = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com/get_customised_recipes_list";


    if(images.isNotEmpty && email.isNotEmpty) {

      print("A------------------------------------");

      Dio dio = new Dio(); // with default Options

      // Set default configs
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = Duration(seconds: 20); //5s
      dio.options.receiveTimeout = Duration(seconds: 20);



      print("B------------------------------------");


      var formData = FormData();
      for (var file in images) {
        formData.files.addAll([
          MapEntry("files[]", await MultipartFile.fromFile(file.path)),
        ]);

        print("file size${file.lengthSync()}");
      }

      formData.fields.add(MapEntry("email", email));

      print("C------------------------------------");

      var response = await dio.post(url, data: formData);

      print("D------------------------------------");

      if (response.statusCode == 200) {
        //apiResponse.onSuccess(response.toString(), eventType);

        print("E------------------------------------");

        print("Image Uploaded");

        var x = jsonEncode(response.data);

        print(x.toString());

        //List<FoodResponseModel> recipes = jsonDecode(x.toString());

        //print(jsonDecode(response.data));

        // return (response.data as List)
        //     .map((x) => FoodResponseModel.fromJson(x))
        //     .toList();

        // Iterable l = json.decode(response.data.toString());
        //
        // print('LENGTH: ${l.length}');
        //
        //
        // List<FoodResponseModel> recipes =
        // List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));

        // return (response.data as List)
        //     .map((x) => FoodResponseModel.fromJson(x))
        //     .toList();

        //return recipes;

        print("AAA");

        //print(data.first["name"]);
        //Iterable l = jsonDecode(response.data);

        print("BBB");

        //List<FoodResponseModel> recipes = List<FoodResponseModel>.from(response.data.map((e) => FoodResponseModel.fromJson(e)));

        //return recipes;

        //GetRecipesResponseModel getRecipesResponseModel = json.decode(x.toString());

        //Iterable l = json.decode(x.toString());

        //  GetRecipesResponseModel getRecipesResponseModel =
        // GetRecipesResponseModel.from(x.toString().map((e) => GetRecipesResponseModel.fromJson(e)));

        print("n1");

        var res = GetCustomisedRecipesResponseModel.fromJson(json.decode(x.toString()));

        print("n2");

        return res;



        //return getRecipesResponseModel;

      } else {
        //apiResponse.onError('Failed to load post');

        print(response.data.toString());

        print("Upload Failed");

        throw Exception("failed");

      }

    } else {
      throw Exception("no images uploaded");
    }


  }




  Future<List<FoodResponseModel>> getBestMatchedRecipes() async{

    await Future.delayed(const Duration(seconds: 10));

    //String url = 'http://10.0.2.2:5000/get_best_matched_recipes';

    String url = "$baseUrl/get_best_matched_recipes";

    print('in future getBestMatchedRecipes');

    final response = await http.post(Uri.parse(url));

    print('A--------------------------------------------------');

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200) {
      print('status code: ${response.statusCode}');

      Iterable l = json.decode(response.body);  //

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


  Future<UserResponseModel> getUserInfo() async{

    //String url = 'http://10.0.2.2:5000/get_best_matched_recipes';

    String url = "$baseUrl/home_data";

    print('in future getUserInfo');

    final response = await http.post(Uri.parse(url));

    print('A--------------------------------------------------');

    print('status code: ${response.statusCode}');

    if(response.statusCode == 200) {

      print('status code: ${response.statusCode}');

      //Iterable l = json.decode(response.body);

      print(response.body);

      return UserResponseModel.fromJson(json.decode(response.body));

    } else {
      throw Exception("failed to load data");
    }

  }


  Future<String> customisedRecipes(List<File> images, String email) async{

    //String url = 'http://10.0.2.2:5000/recognise_ingredients';

    String url = "http://fyp-trial-2-env.eba-cwcfw5nz.eu-west-2.elasticbeanstalk.com/recognise_ingredients_for_customisation";

    if(images.isNotEmpty) {

      print("A------------------------------------");

      Dio dio = new Dio(); // with default Options

      // Set default configs
      dio.options.baseUrl = baseUrl;
      dio.options.connectTimeout = Duration(seconds: 20); //5s
      dio.options.receiveTimeout = Duration(seconds: 20);

      print("B------------------------------------");


      var formData = FormData();
      for (var file in images) {
        formData.files.addAll([
          MapEntry("files[]", await MultipartFile.fromFile(file.path)),
        ]);

        print("file size${file.lengthSync()}");
      }

      print("EMAIL ADDRESS:::$email");

      formData.fields.add(MapEntry("email", email));

      print("C------------------------------------");

      var response = await dio.post(url, data: formData);

      print("D------------------------------------");

      if (response.statusCode == 200) {
        //apiResponse.onSuccess(response.toString(), eventType);

        print("E------------------------------------");

        print("Image Uploaded");

        print(response.data.toString());

        return response.data.toString();


      } else {
        //apiResponse.onError('Failed to load post');

        print(response.data.toString());

        print("Upload Failed");

        return "failed";

      }

    } else {
      return "no images";
    }


  }


  Future<List<FoodResponseModel>> getBestMatchedCustomisedRecipes() async{

    //String url = 'http://10.0.2.2:5000/get_best_matched_recipes';

    String url = "$baseUrl/get_best_matched_customised_recipes";

    print('in future getBestMatchedCustomisedRecipes');

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