class FoodResponseModel {

  final String _id;
  final String name;
  final String ingredients;
  final String method;
  final String nutritionInfo;
  final String country;
  final String tags;
  final String prepTime;
  final String cookTime;
  final String difficultyLevel;
  final String servings;
  final String imageUrl;

  FoodResponseModel(this._id, this.name, this.ingredients, this.method, this.nutritionInfo,
      this.country, this.tags, this.prepTime, this.cookTime, this.difficultyLevel,
      this.servings, this.imageUrl);

  FoodResponseModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        name = json['response'],
        ingredients = json['response'],
        method = json['method'],
        nutritionInfo = json['nutritionInfo'],
        country = json['country'],
        tags = json['tags'],
        prepTime = json['prepTime'],
        cookTime = json['cookTime'],
        difficultyLevel = json['difficultyLevel'],
        servings = json['servings'],
        imageUrl = json['imageUrl'];
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