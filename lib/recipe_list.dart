import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/api/api_service.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  Map data = {};

  APIService apiService = APIService();

  //late List<FoodResponseModel> recipes;

  late Future <List<FoodResponseModel>> _recipes;

  late Future <GetRecipesResponseModel> _response;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getTextWidgets(List<String> data)
  {
    List<Widget> list = <Widget>[];

    for(var i = 0; i < data.length; i++){
      list.add(Flexible(child:
      Text(data[i])
      )
      );
    }

    return SizedBox(height: 60,
      child: Column(children: list),);
  }


  Widget getRecipeWidgets(List<FoodResponseModel> recipes)
  {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < recipes.length; i++){
//
      list.add(Flexible(
          child: GestureDetector(

            child:
            Padding(
              padding: const EdgeInsets.all(7),
              child: Card(
                color: Colors.white70,
                //margin: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //
                      Flexible(

                        child: ListTile(

                          title: Text(recipes[i].name),
                        ),
                      ),


                      //

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 20),
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 70,
                            width: 70,
                            color: Colors.white,
                            child: Image.network(recipes[i].imageUrl),
                        ),
                      ),

                    ],
                  ),
                ),
                //ONCLICK
              ),
            ),
            onTap: () =>
                Navigator.pushNamed(context, '/individual_recipe',
                    arguments: {'data': recipes[i], 'photos': data['photos'], 'email': data['email'], 'username': data['username'], 'bmi': data['bmi']}),
          )
      ));
    }
    return SizedBox(
      height: 1200,
      child: Column(children: list),
    );
  }


  @override
  Widget build(BuildContext context) {

    setState(() {
      if (data.isNotEmpty) {
        data = data;
      } else {
        data = ModalRoute.of(context)?.settings.arguments as Map;
      }
      print("DATAAAAA:    "+data.toString());
      // _recipes = data["recipe_data"];

       _response = apiService.foodRecognition(data['photos']);


    });
//






    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Suggestions'), backgroundColor: Colors.deepPurple,),

      body: SafeArea(
          child:

          SingleChildScrollView(
            child:
            Column(
                children: [

                  SingleChildScrollView(
                    child: FutureBuilder<GetRecipesResponseModel> (
                      future: _response,
                      //initialData: [],
                      builder: (context, snapshot) {

                        // if(snapshot.data==null) {
                        //   return const CircularProgressIndicator(color: Colors.deepPurple,);
                        // }
                        if(snapshot.hasData) {

                          var x = jsonEncode(snapshot.data!.recipes);

                          Iterable l = json.decode(x.toString());

                          List<FoodResponseModel> recipes = List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));

                          var recognisedIngredients = snapshot.data!.ingredients.toString().replaceAll("[", "");
                          recognisedIngredients = recognisedIngredients.replaceAll("]", "");

                          return SizedBox(
                            height: 1000,
                            child:

                            SingleChildScrollView(
                              child: Column(

                                children: [
                                  // Text(snapshot.data!.first.ingredients),
                                  // SizedBox(height: 10.0,),
                                  // Text(snapshot.data!.first.name)


                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Text("Recognised Ingredients: $recognisedIngredients",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                                  ),


                                  getRecipeWidgets(recipes),

                                  // ElevatedButton(
                                  //   style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                                  //   child: const Text('Find Customised Recipes'),
                                  //   onPressed: (){
                                  //
                                  //     Navigator.pushNamed(context, '/customised_recipe_list',
                                  //         arguments: {'photos': data['photos'], 'email': data['email'], 'username': data['username'], 'bmi': data['bmi']});
                                  //
                                  //     //APIService apiService = APIService();  //
                                  //
                                  //     // apiService.customisedRecipes(data['photos'], data['email']).then((value) => {
                                  //     //   if(value.isNotEmpty && value=="5_cutomised_recipes_extracted") {
                                  //     //
                                  //     //
                                  //     //   }
                                  //     // });
                                  //
                                  //     //
                                  //
                                  //   },
                                  // ),

                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator(color: Colors.deepPurple,);
                      },
                    ),
                  ),



                ]
            ),
          )
      ),
    );
  }

}