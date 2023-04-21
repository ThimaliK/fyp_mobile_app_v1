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
              return Center(
                child: Column(
                  children: [
                    Text(snapshot.data!.first.ingredients),
                    SizedBox(height: 10.0,),
                    Text(snapshot.data!.first.name)

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
