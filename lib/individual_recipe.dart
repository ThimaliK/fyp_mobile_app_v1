import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';

class IndividualRecipe extends StatefulWidget {
  const IndividualRecipe({Key? key}) : super(key: key);

  @override
  State<IndividualRecipe> createState() => _IndividualRecipeState();
}

class _IndividualRecipeState extends State<IndividualRecipe> {


  Map data = {};

  Widget getMethodSteps(List<String> methodStepsList)
  {

    try {
      List titlesAndSteps = [];

      for (var j = 0; j < methodStepsList.length; j++) {
        var titleAndStep = methodStepsList[j].split("*");

        titlesAndSteps.add(titleAndStep);
      }


      List<Widget> list = <Widget>[];

      for (var i = 0; i < titlesAndSteps.length; i++) {
        list.add(

            Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Text(titlesAndSteps[i][0].trim())
            )

        );

        list.add(Text(titlesAndSteps[i][1].trim()));
      }


      return

        Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list),
        );
    } catch (e){
      return getTextWidgets(methodStepsList);
    }

  }

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


    setState(() {

      if (data.isNotEmpty) {
        data = data;
      } else {

        print('getting route data---------------------');
        data = ModalRoute.of(context)?.settings.arguments as Map;
      }

    });


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
              children: [Image.network(recipe.imageUrl),]
            ),


            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: getTextWidgets(ingredientList)
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: getMethodSteps(methodSteps)
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: getTextWidgets(nutritionInfoList)
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Country: ${recipe.country}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Cook time: ${recipe.cookTime.toString()}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Prep time: ${recipe.prepTime.toString()}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Servings: ${recipe.servings.toString()}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Difficulty level: ${recipe.difficultyLevel.toString()}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Tags: ${recipe.tags}")
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home',
                          arguments: {'username': data['username'], 'bmi': data['bmi'], 'email': data['email']});
                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70, maximumSize: const Size.fromHeight(50),
                        shadowColor: Colors.black,
                        side: const BorderSide(
                            width: 1, // the thickness
                            color: Colors.black // the color of the border
                        )
                    ),
                    child: const Text('Back to Home', style: TextStyle(color: Colors.black),),
                  ),
              ),
            ),



          ],
        ),
      )
    );
  }


}
