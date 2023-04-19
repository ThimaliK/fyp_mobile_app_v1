class Recipe {
  //String id;
  String name;
  String ingredients;
  String method;
  String nutritionInfo;
  String country;
  String tags;
  String prepTime;
  String cookTime;
  String difficultyLevel;
  String servings;
  String imageUrl;

  Recipe.fromJson(Map json)
      :
        //id = json['_id'],
        name = json['name'],
        ingredients = json['ingredients'],
        method = json['method'],
        nutritionInfo = json['nutrition_info'],
        country = json['country'],
        tags = json['tags'],
        prepTime = json['prepTime'],
        cookTime = json['cookTime'],
        difficultyLevel = json['difficultyLevel'],
        servings = json['servings'],
        imageUrl = json['imageUrl']
  ;

  Map toJson() {
    return {
      //'_id': id,
      'name': name, 'ingredients': ingredients, 'method': method, 'nutrition_info': nutritionInfo,
    'country': country, 'tags': tags, 'prep_time': prepTime, 'cook_time': cookTime, 'difficulty_level': difficultyLevel,
    'servings': servings, 'image_url': imageUrl};
  }
}