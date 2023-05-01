class LoginResponseModel {

  final String username;
  final String bmi;
  final String email;

  LoginResponseModel(this.username, this.bmi, this.email);

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : username = json['username'], bmi = json['bmi'].toString(), email = json['email'];

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