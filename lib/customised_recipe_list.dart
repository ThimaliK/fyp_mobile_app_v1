import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/api/api_service.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';

class CustomisedRecipeList extends StatefulWidget {
  const CustomisedRecipeList({Key? key}) : super(key: key);

  @override
  State<CustomisedRecipeList> createState() => _CustomisedRecipeListState();
}

class _CustomisedRecipeListState extends State<CustomisedRecipeList> {

  Map data = {};
  APIService apiService = APIService();

  late Future <GetCustomisedRecipesResponseModel> _response;

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

                      Flexible(
                        child: ListTile(
                          title: Text(recipes[i].name),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 20),
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
                    arguments: {'data': recipes[i], 'photos': data['photos'], 'email': data['email'], 'bmi': data['bmi'], 'username': data['username']}),
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
      _response = apiService.getCustomisedRecipes(data['email']);

    });


    return Scaffold(
      appBar: AppBar(title: const Text('Recipes based on your Preferences'), backgroundColor: Colors.deepPurple,),

      body: SafeArea(
          child:

          SingleChildScrollView(
            child:
            Column(
                children: [

                  SingleChildScrollView(
                    child: FutureBuilder<GetCustomisedRecipesResponseModel> (
                      future: _response,
                      builder: (context, snapshot) {
                        if(snapshot.data==null) {
                          return
                            Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(color: Colors.deepPurple,)
                            );
                        }
                        else if(snapshot.hasData) {

                          var x = jsonEncode(snapshot.data!.recipes);

                          Iterable l = json.decode(x.toString());

                          List<FoodResponseModel> recipes = List<FoodResponseModel>.from(l.map((e) => FoodResponseModel.fromJson(e)));

                          return SizedBox(
                            height: 1000,
                            child:

                            SingleChildScrollView(
                              child: Column(

                                children: [

                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                      child: Text("Recipes based on : ${"${snapshot.data!.foodPreferences}, ${snapshot.data!.country}"}",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                                  ),

                                  getRecipeWidgets(recipes)

                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return
                          Container(
                              height: 200,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(color: Colors.deepPurple,)
                          );
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