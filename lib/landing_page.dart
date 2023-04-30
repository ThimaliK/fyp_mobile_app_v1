import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('MyHealth'),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
    ),
        body:

        // Padding(
        //     padding: const EdgeInsets.all(15),
        //     child:

    // Padding(
    //   padding: const EdgeInsets.all(20),
      // child: SingleChildScrollView(
         //child:

        Column(
                  children: <Widget>[

                    const SizedBox(
                      height: 30,
                    ),

                    Container(
                      color: Colors.white,
                      child: Image.asset(
                        'assets/landing_page_image.jpg',
                      )
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.all(20),
                      child:

                      // Container(
                      //   child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, minimumSize: Size(500, 40),),
                          child: const Text('Create Account'),
                          onPressed: (){
                            Navigator.pushNamed(context, '/sign_up');
                          },
                        ),

                      ),

                    //),

                    // const SizedBo//   height: 10,
                    // ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, minimumSize: Size(500, 40)),
                        child: const Text('Login'),
                        onPressed: (){
                          Navigator.pushNamed(context, '/sign_in');
                        },
                      ),
                    ),
                  ],
                ),
      //),
    //)
        //)
    );


  }

}



