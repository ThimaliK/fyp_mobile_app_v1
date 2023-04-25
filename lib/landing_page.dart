import 'package:flutter/material.dart';




class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('MyHealth'),
      backgroundColor: Colors.deepPurple,
    ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[


                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                  child: const Text('Log In'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign_in');
                  },
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                  child: const Text('Create Account'),
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign_up');
                  },
                )
              ],
            )
        )
    );


  }

}



