import 'package:flutter/material.dart';

import 'api/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String currentUsername = "";
  String currentBmi = "";

  Map data = {};

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

    if (data.isNotEmpty) {
      data = data;
    } else {

      print('getting route data---------------------');
      data = ModalRoute.of(context)?.settings.arguments as Map;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyHealth'),
        backgroundColor: Colors.deepPurple[700],
        centerTitle: true,
      ),
      body: 
          
      Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10,),
              Text('Hi ${data['username']}, Welcome Back!', style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              GestureDetector(
                child:
                SizedBox(
                  height: 280,
                  child: Card(
                    color: Colors.purple[100],
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        const Expanded(
                          child: ListTile(
                            title: Text("Take photos of ingredients to find Healthy Recipes!", textAlign: TextAlign.center,),
                          ),
                        ),
                        IconButton(onPressed: () {
                          Navigator.pushNamed(context, '/camera_input', arguments: {'email': data['email'], 'username': data['username'], 'bmi': data['bmi']});
                        },
                          icon: const Icon(Icons.camera_alt_rounded, color: Colors.black,),
                          iconSize: 200,
                        ),
                      ],
                    )

                  ),
                ),
                onTap: () => Navigator.pushNamed(context, '/camera_input', arguments: {'email': data['email'], 'username': data['username'], 'bmi': data['bmi']}),
              ),
              const SizedBox(height: 10,),
              Card(
                color: Colors.blue[100],
                child: Row (
                  children: [
                    IconButton(onPressed: () {

                    },
                      icon: const Icon(Icons.directions_walk),
                      iconSize: 100,
                      alignment: Alignment.centerLeft,
                    ),
                    Flexible(
                        child: ListTile(
                          title: Text("Your Bmi: ${data['bmi']}"),
                        )
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
