import 'package:fyp_mobile_app_v1/recipe.dart';

class RecipeCollection {
  //String id;
  List<Recipe> recipeList;

  RecipeCollection.fromJson(Map json)
      :
        //id = json['_id'],
        recipeList = json['']

  ;

  Map toJson() {
    return {'': recipeList};
  }
}