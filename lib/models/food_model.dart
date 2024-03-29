class FoodResponseModel {

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

  FoodResponseModel(
      this.name, this.ingredients, this.method, this.nutritionInfo,
      this.country, this.tags, this.prepTime, this.cookTime, this.difficultyLevel,
      this.servings, this.imageUrl);

  FoodResponseModel.fromJson(Map<String, dynamic> json)
      :
        name = json['name'].toString(),
        ingredients = json['ingredients'].toString(),
        method = json['method'].toString(),
        nutritionInfo = json['nutrition_info'].toString(),
        country = json['country'].toString(),
        tags = json['tags'].toString(),
        prepTime = json['prep_time'].toString(),
        cookTime = json['cook_time'].toString(),
        difficultyLevel = json['difficulty_level'].toString(),
        servings = json['servings'].toString(),
        imageUrl = json['image_url'].toString();
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

class GetRecipesResponseModel {
  final List<dynamic> recipes;
  final List<dynamic> ingredients;

  GetRecipesResponseModel(this.recipes, this.ingredients);

  GetRecipesResponseModel.fromJson(Map<String, dynamic> json)
      : recipes = json['recipes'], ingredients = json['ingredients'];

}

class GetCustomisedRecipesResponseModel {
  final List<dynamic> recipes;
  final String country;
  final String foodPreferences;

  GetCustomisedRecipesResponseModel(this.recipes, this.country, this.foodPreferences);

  GetCustomisedRecipesResponseModel.fromJson(Map<String, dynamic> json)
      : recipes = json['recipes'], country = json['country'], foodPreferences = json['food_preferences'];

}