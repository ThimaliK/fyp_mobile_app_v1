class UserResponseModel {

  final String username;
  final String bmi;

  UserResponseModel(this.username, this.bmi);

  // factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
  //
  //   return LoginResponseModel(response: json["response"] ?? "");
  // }

  UserResponseModel.fromJson(Map<String, dynamic> json)
      : username = json['username'], bmi = json['bmi'].toString();

}

// class LoginRequestModel {
//   String email;
//   String password;
//
//   LoginRequestModel(this.email, this.password);
//
//   Map <String, dynamic> toJson() {
//
//     Map<String, dynamic> map = {'email': email.trim(), 'password': password.trim()};
//     return map;
//   }


//}