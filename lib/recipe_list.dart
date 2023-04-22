import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/api/api_service.dart';
import 'dart:io';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //APIService apiService = APIService();
    //recipes = apiService.getBestMatchedRecipes() as List<FoodResponseModel>;

    // apiService.getBestMatchedRecipes().then((value) => {
    //   print('INGREDIENTS IN RECIPE LIST - ${value.first.ingredients}'),
    //
    //
    //   recipes = value
    // });
    //
    // print("in recipes list view last ${recipes.first.ingredients}");
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

    return new SizedBox(height: 60,
    child: Column(children: list),);
  }


  Widget getRecipeWidgets(List<FoodResponseModel> recipes)
  {
    List<Widget> list = <Widget>[];
    for(var i = 0; i < recipes.length; i++){

      final ingredientList = recipes[i].ingredients.split(',');
      final methodSteps = recipes[i].method.split("--");
      final nutritionInfoList = recipes[i].nutritionInfo.split(",");

      list.add(Flexible(
        child: GestureDetector(
          child: Card(
            child: SizedBox(
              height: 100,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Text(recipes[i].name),
                    ),
                  ),
                  // Flexible(child: Text("Ingredients"),),
                  // getTextWidgets(ingredientList),

                ],
              ),
            ),
            color: Colors.grey,
            margin: EdgeInsets.all(5),
            //ONCLICK
          ),
          onTap: () =>
          Navigator.pushNamed(context, '/individual_recipe',
              arguments: {'data': recipes[i]})
          ,
        )
      ));
    }
    return new SizedBox(
      height: 750,
      child: Column(children: list),
    );
  }


  @override
  Widget build(BuildContext context) {

    if (data.isNotEmpty) {
      data = data;
    } else {
      data = ModalRoute.of(context)?.settings.arguments as Map;
    }

    List <File> _images = data['photos'];

    //List<FoodResponseModel> recipes = data['recipes'];

    //print('Recipes from recipe list view$recipes');


    

    return Scaffold(
      appBar: AppBar(title: Text('recipe list')),
      body: SafeArea(
        child:
        // Container(
        //     padding: EdgeInsets.all(12.0),
        //     child: GridView.builder(
        //       itemCount: _images.length,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           crossAxisSpacing: 4.0,
        //           mainAxisSpacing: 4.0
        //       ),
        //       itemBuilder: (BuildContext context, int index){
        //         return Image.file(_images[index]);
        //       },
        //     )),
        FutureBuilder<List<FoodResponseModel>> (
          future: apiService.getBestMatchedRecipes(),
          builder: (context, snapshot) {
            if(snapshot.data==null) {
              return CircularProgressIndicator();
            }
            else if(snapshot.hasData) {
              return SizedBox(
                height: 1000,
                child: Column(

                  children: [
                    // Text(snapshot.data!.first.ingredients),
                    // SizedBox(height: 10.0,),
                    // Text(snapshot.data!.first.name)

                    getRecipeWidgets(snapshot.data!)



                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )
      ),
    );
  }

}
