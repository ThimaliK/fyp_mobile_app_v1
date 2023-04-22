import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';

class IndividualRecipe extends StatefulWidget {
  const IndividualRecipe({Key? key}) : super(key: key);

  @override
  State<IndividualRecipe> createState() => _IndividualRecipeState();
}

class _IndividualRecipeState extends State<IndividualRecipe> {


  Map data = {};







  @override
  Widget build(BuildContext context) {


    if (data.isNotEmpty) {
      data = data;
    } else {

      print('getting route data---------------------');
      data = ModalRoute.of(context)?.settings.arguments as Map;
    }

    print(data);

    FoodResponseModel recipe = data['data'];



    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Text(recipe.name),
          Text(recipe.ingredients),
          Text(recipe.method),
        ],
      )
    );
  }

  // Future <FoodResponseModel> getSomething() async {
  //
  //
  //   FoodResponseModel recipe = await data['data'];
  //
  //   if (recipe==null) {
  //     return FoodResponseModel("name", "name", "name", "name", "name", "name", 1, 1, "name", 1, "name");
  //   }
  //
  //   print('in get something');
  //   return recipe;
  // }
}
