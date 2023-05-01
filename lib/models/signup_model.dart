class SignupResponseModel {

  final String response;

  SignupResponseModel(this.response);

  SignupResponseModel.fromJson(Map<String, dynamic> json)
      : response = json['response'];
}

class SignupRequestModel {

  String username;
  String email;
  String password;
  String country;
  String birthDate;
  String foodPreferences;
  String weight;
  String height;
  String fitbitUserID;

  SignupRequestModel(this.username, this.email, this.password, this.country,
      this.birthDate, this.foodPreferences, this.weight, this.height, this.fitbitUserID);

  Map <String, dynamic> toJson() {

    Map<String, dynamic> map = {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'country': country.trim(),
      'birthDate': birthDate.trim(),
      'foodPreferences': foodPreferences.trim(),
      'weight': weight.trim(),
      'height': height.trim(),
      'fit_bit_id': fitbitUserID.trim()
    };
    return map;
  }


}