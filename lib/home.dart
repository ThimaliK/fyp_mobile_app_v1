import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              const Text('Welcome to MyHealth'),
              const SizedBox(height: 10,),
              Card(
                color: Colors.purple[100],
                child:
                IconButton(onPressed: () {
                  Navigator.pushNamed(context, '/camera_input');
                },
                    icon: const Icon(Icons.camera_alt),
                  iconSize: 250,
                ),
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
                    const Flexible(
                        child: ListTile(
                          title: Text("Step Count: "),
                        )
                    ),
                  ],
                )



              ),

              // Row(
              //   children: <Widget>[
              //     Card(
              //       color:
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
