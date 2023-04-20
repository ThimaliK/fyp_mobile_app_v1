import 'package:fyp_mobile_app_v1/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async{
    String url = 'http://10.0.2.2:5000/sign_in';

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

    if(response.statusCode == 200) {
      print('status code: ${response.statusCode}');
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load data");
    }

  }

}