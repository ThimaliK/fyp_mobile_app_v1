import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String currentUsername = "";
  String currentBmi = "";

  APIService apiService = APIService();

  //Map data = {};

  late Future <LoginResponseModel> _response;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // APIService apiService = APIService();
    // apiService.getUserInfo().then((value) => {
    //   if(value.username.isNotEmpty) {
    //
    //     setState(() {
    //       currentUsername = value.username;
    //       currentBmi = value.bmi;
    //     })
    //
    //   }
    // });




  }

  @override
  Widget build(BuildContext context) {

    // if (data.isNotEmpty) {
    //   data = data;
    // } else {

      // print('getting route data---------------------');
      // data = ModalRoute.of(context)?.settings.arguments as Map;



    //}

    setState(() {

      _response = apiService.loadLoginData();
    });



    return Scaffold(
      appBar: AppBar(
        title: const Text('MyHealth'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: 
          
      Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FutureBuilder<LoginResponseModel>(
            future: _response,
            builder: (context, snapshot) {


              if(snapshot.hasData) {

                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 5,),
                    Text('Hi ${snapshot.data!.username}, Welcome Back!', style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,),
                    const SizedBox(height: 10,),

                    GestureDetector(
                      child:
                      SizedBox(
                        height: 200,
                        child:

                        Card(
                            color: Colors.purple[100],
                            child:
                            Column(
                              children: [
                                const SizedBox(height: 10,),
                                const Expanded(

                                  child: ListTile(
                                    title: Text(
                                      "Take photos of ingredients to find Healthy Recipes!", textAlign: TextAlign.center,),
                                  ),
                                ),
                                IconButton(onPressed: () {
                                  Navigator.pushNamed(context, '/camera_input', arguments: {'email': snapshot.data!.email, 'username': snapshot.data!.username, 'bmi': snapshot.data!.bmi});
                                },
                                  icon: const Icon(Icons.camera_alt_rounded, color: Colors.black,),
                                  iconSize: 130,
                                ),
                              ],
                            )

                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/camera_input', arguments: {'email': snapshot.data!.email, 'username': snapshot.data!.username, 'bmi': snapshot.data!.bmi}),
                    ),

                    const SizedBox(height: 10,),

                    GestureDetector(
                      child:
                      SizedBox(
                        height: 200,
                        child:

                        Card(
                            color: Colors.green[100],
                            child:
                            Column(
                              children: [
                                const SizedBox(height: 10,),
                                const Expanded(

                                  child: ListTile(
                                    title: Text(
                                      "Find Recipes based on your Food Preferences!", textAlign: TextAlign.center,),
                                  ),
                                ),
                                IconButton(onPressed: () {
                                  Navigator.pushNamed(context, '/customised_recipe_list', arguments: {'email': snapshot.data!.email, 'username': snapshot.data!.username, 'bmi': snapshot.data!.bmi});
                                },
                                  icon: const Icon(Icons.favorite_rounded, color: Colors.black,),
                                  iconSize: 130,
                                ),
                              ],
                            )

                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/customised_recipe_list', arguments: {'email': snapshot.data!.email, 'username': snapshot.data!.username, 'bmi': snapshot.data!.bmi}),
                    ),

                    const SizedBox(height: 10,),
                    Card(
                        color: Colors.blue[100],
                        child: Row (
                          children: [
                            IconButton(onPressed: () {

                            },
                              icon: const Icon(Icons.fitness_center_rounded),
                              iconSize: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            Flexible(
                                child: ListTile(
                                  title: Text("Your Bmi: ${snapshot.data!.bmi}"),
                                )
                            ),
                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                      child: const Text('Logout'),
                      onPressed: (){
                        setState(() {
                          apiService.logoutUser();
                          Navigator.pushNamed(context, '/landing');
                        });
                      },
                    ),
                  ],
                );

              }else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator(color: Colors.deepPurple,);

            }


          ),
        ),
      ),
    );
  }
}
