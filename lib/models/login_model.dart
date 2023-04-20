class LoginResponseModel {

  final String response;

  LoginResponseModel(this.response);

  // factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
  //
  //   return LoginResponseModel(response: json["response"] ?? "");
  // }

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : response = json['response'];

}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel(this.email, this.password);

  Map <String, dynamic> toJson() {

    Map<String, dynamic> map = {'email': email.trim(), 'password': password.trim()};
    return map;
  }


}