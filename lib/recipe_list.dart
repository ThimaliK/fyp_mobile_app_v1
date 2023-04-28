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
                margin: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 100,
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
                      // Flexible(child: Text("Ingredients"),),
                      // getTextWidgets(ingredientList),

                      //

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 25),
                        child: Container(
                          alignment: Alignment.centerRight,
                          height: 60,
                            width: 60,
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
                    arguments: {'data': recipes[i]}),
          )
      ));
    }
    return SizedBox(
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



    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Suggestions'), backgroundColor: Colors.deepPurple,),

      body: SafeArea(
          child:

          SingleChildScrollView(
            child:
            Column(
                children: [

                  SingleChildScrollView(
                    child: FutureBuilder<List<FoodResponseModel>> (
                      future: apiService.getBestMatchedRecipes(),
                      builder: (context, snapshot) {
                        if(snapshot.data==null) {
                          return const CircularProgressIndicator();
                        }
                        else if(snapshot.hasData) {
                          return SizedBox(
                            height: 750,
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
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                    child: const Text('Find Customised Recipes'),
                    onPressed: (){

                    },
                  ),

                ]
            ),
          )
      ),
    );
  }

}