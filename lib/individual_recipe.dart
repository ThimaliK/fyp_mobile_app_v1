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
      list.add(

      Text(data[i].trim())

      );
    }
    return

      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: list),
      );
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
      SingleChildScrollView(
        child:
        Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(15),
                child: Text(recipe.name, style: const TextStyle(fontSize: 20),)
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Image.asset(
                    'assets/landing_page_image.jpg',
              ),]
            ),


            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: getTextWidgets(ingredientList)
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: getTextWidgets(methodSteps)
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: getTextWidgets(nutritionInfoList)
              ),
            ),



          ],
        ),
      )
    );
  }


}
