import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/api/api_service.dart';
import 'package:fyp_mobile_app_v1/models/login_model.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = "";

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  late LoginRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel(emailController.text, passwordController.text);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('MyHealth'),
      backgroundColor: Colors.deepPurple,
      centerTitle: true,
    ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: 
            
            SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  const SizedBox(height: 20,),

                  const Text("Log in to your MyHealth Account", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter your email',
                      ),
                      controller: emailController,
                      cursorColor: Colors.deepPurple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter your Password',
                      ),
                      controller: passwordController,
                      cursorColor: Colors.deepPurple,
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(message, style: const TextStyle(color: Colors.red),)

                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, minimumSize: const Size(500, 40)),
                      onPressed: (){
                        String email = emailController.text;
                        String password = passwordController.text;

                        setState(() {

                        });

                        requestModel.email = email;
                        requestModel.password = password;

                        setState(() {

                        });

                        APIService apiService = APIService();

                        apiService.login(requestModel).then((value) => {
                          if(value.email.isNotEmpty) {
                              Navigator.pushNamed(context, '/home',
                                  arguments: {'username': value.username, 'bmi': value.bmi, 'email': value.email})

                          } else {
                            setState(() {

                              message = value.username;

                            })
                          }
                        });
                      },
                      child: const Text('Log In'),
                    ),
                  )
                ],
              ),
            )
        )
    );


  }

}



