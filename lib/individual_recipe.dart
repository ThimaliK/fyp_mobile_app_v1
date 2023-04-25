import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';

class IndividualRecipe extends StatefulWidget {
  const IndividualRecipe({Key? key}) : super(key: key);

  @override
  State<IndividualRecipe> createState() => _IndividualRecipeState();
}

class _IndividualRecipeState extends State<IndividualRecipe> {


  Map data = {};

  Widget getTextWidgets(List<String> data)
  {
    List<Widget> list = <Widget>[];

    for(var i = 0; i < data.length; i++){
      list.add(Flexible(child:
      Text(data[i])
      )
      );
    }
    return SizedBox(height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: list),);
  }



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

    final ingredientList = recipe.ingredients.split(',');
    final methodSteps = recipe.method.split("--");
    final nutritionInfoList = recipe.nutritionInfo.split(",");



    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
      ),
      body: 
      Column(
        children: <Widget>[
          // Text(recipe.name),
          // Text(recipe.ingredients),
          // Text(recipe.method),

          Flexible(
            child: ListTile(
              title: Text(recipe.name),
            ),
          ),
          getTextWidgets(ingredientList),
          //SizedBox(height: 7,),
          Padding(
            padding: EdgeInsets.all(20),
              child: getTextWidgets(methodSteps)),
          //getTextWidgets(nutritionInfoList),
          // SizedBox(height: 10,),
          // getTextWidgets(nutritionInfoList)
        ],
      )
    );
  }


}
