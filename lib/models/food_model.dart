class FoodResponseModel {

  //final String _id;
  final String name;
  final String ingredients;
  final String method;
  final String nutritionInfo;
  final String country;
  final String tags;
  final int prepTime;
  final int cookTime;
  final String difficultyLevel;
  final int servings;
  final String imageUrl;

  FoodResponseModel(
      //this._id,
      this.name, this.ingredients, this.method, this.nutritionInfo,
      this.country, this.tags, this.prepTime, this.cookTime, this.difficultyLevel,
      this.servings, this.imageUrl);

  FoodResponseModel.fromJson(Map<String, dynamic> json)
      :
  // _id = json['_id'],
        name = json['name'],
        ingredients = json['ingredients'],
        method = json['method'],
        nutritionInfo = json['nutrition_info'],
        country = json['country'],
        tags = json['tags'],
        prepTime = json['prep_time'],
        cookTime = json['cook_time'],
        difficultyLevel = json['difficulty_level'],
        servings = json['servings'],
        imageUrl = json['image_url'];
}

class FoodResponseListModel {

  final List<FoodResponseModel> response;

  FoodResponseListModel(this.response);

  FoodResponseListModel.fromJson(Map<String, dynamic> json)
  : response = json['response'];

}

class FoodRecognitionResponseModel {
  final String response;

  FoodRecognitionResponseModel(this.response);

  FoodRecognitionResponseModel.fromJson(Map<String, dynamic> json)
      : response = json['response'];
}

// class FoodRequestModel {
//   String email;
//   String password;
//
//   FoodRequestModel(this.email, this.password);
//
//   Map <String, dynamic> toJson() {
//
//     Map<String, dynamic> map = {'email': email.trim(), 'password': password.trim()};
//     return map;
//   }
//
//
// }