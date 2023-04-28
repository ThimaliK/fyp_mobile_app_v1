import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/signup_model.dart';
import 'package:country_picker/country_picker.dart';
import 'api/api_service.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  List<String> tags = [];
  List<String> options = ['Healthy', 'Low calorie', 'Freezable', 'French cuisine', 'Fresh',
  'Vegetarian', 'Vegan', 'Gluten-free', 'Flavourful', 'Rich in protein', 'Indian cuisine', 'Spicy', 'Low-fat',
  'Mediterranean', 'Asian cuisine', 'Fruity', 'Dairy', 'Warm', 'Sweet', 'Italian cuisine',
  'Egg-free', 'Dairy-free', ];

  String validationMessage = "";

  //int tag = 0;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fitbitIdController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String selectedCountry = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fitbitIdController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  late SignupRequestModel requestModel;

  @override
  void initState() {
    super.initState();

    requestModel = SignupRequestModel(
      usernameController.text,
      emailController.text,
      passwordController.text,
      selectedCountry,
      '12/12/2000',
      tags.toString(),
      fitbitIdController.text
    );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a new Account'),
          backgroundColor: Colors.deepPurple,
        ),
        body:
        SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter your username',
                      ),
                      cursorColor: Colors.deepPurple,
                      controller: usernameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter your email address',

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
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter password',
                      ),
                      controller: passwordController,
                      cursorColor: Colors.deepPurple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter password again to confirm',
                      ),
                      controller: confirmPasswordController,
                      cursorColor: Colors.deepPurple,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        ),
                        labelText: 'Fitbit User ID',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        hintText: 'Enter Fitbit User ID to view health data',
                      ),
                      controller: fitbitIdController,
                      cursorColor: Colors.deepPurple,
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        showCountryPicker(

                          context: context,
                          //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                          exclude: <String>['KN', 'MF'],
                          favorite: <String>['SE'],
                          //Optional. Shows phone code before the country name.
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            print('Select country: ${country.displayName}');
                            setState(() {
                              selectedCountry = country.displayName.split(" ").first.toString();
                            });

                          },
                          // Optional. Sets the theme for the country list picker.
                          countryListTheme: CountryListThemeData(
                            // Optional. Sets the border radius for the bottomsheet.
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            // Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                            // Optional. Styles the text in the search field
                            searchTextStyle: const TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, maximumSize: const Size.fromHeight(50),
                          side: const BorderSide(
                          width: 1, // the thickness
                          color: Colors.black54 // the color of the border
                      )),
                      child: Text('Click to select Country $selectedCountry',
                        style: const TextStyle(color: Colors.deepPurple),),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ChipsChoice<String>.multiple(
                      value: tags,
                      onChanged: (val) => setState(()=> tags = val),
                      wrapped: true,
                      choiceItems: C2Choice.listFrom(source: options, value: (i, v) => v, label: (i, v) => v),
                      choiceActiveStyle: const C2ChoiceStyle(color: Colors.deepPurple,
                          borderColor: Colors.deepPurple,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      choiceStyle: const C2ChoiceStyle(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(validationMessage, style: const TextStyle(color: Colors.red),)
                  ),
                  ElevatedButton(
                    onPressed: (){

                      final bool isValidEmail = EmailValidator.validate(emailController.text.trim());

                      if(isValidEmail==false) {
                        setState(() {
                          validationMessage = "Invalid email address";
                        });
                      } else if(usernameController.text.trim()=="" ||
                                emailController.text.trim()=="" ||
                                passwordController.text.trim()=="" ||
                          confirmPasswordController.text.trim()=="") {
                        setState(() {
                          validationMessage = "Some required fields are empty";
                        });

                      } else if(passwordController.text.trim().length<6) {
                        setState(() {
                          validationMessage = "The password must contain at least 6 characters";
                        });
                      }
                      else if(passwordController.text.trim() != confirmPasswordController.text.trim()) {
                        setState(() {
                          validationMessage = "Password and password confirmation do not match";
                        });
                      }

                      else {

                        requestModel.username = usernameController.text;
                        requestModel.email = emailController.text;
                        requestModel.password = passwordController.text;
                        requestModel.country = selectedCountry;
                        requestModel.birthDate = "12/12/2000";
                        requestModel.foodPreferences = tags.toString();
                        requestModel.fitbitUserID = fitbitIdController.text;

                        setState(() {

                        });

                        print(requestModel.toJson());

                        APIService apiService = APIService();

                        print('api service created');

                        print("THE TAGS ---------${tags.toString()}");

                        apiService.register(requestModel).then((value) => {
                          if(value.response.isNotEmpty) {
                            if(value.response == "registration successful") {
                              Navigator.pushNamed(context, '/')
                            } else {
                              setState(() {
                                validationMessage = value.response.toString();
                              })
                            }
                          }
                        });

                      }

                    },
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                    child: const Text('Create Account')
                  ),

                ],
              )
          ),
        )
      );

  }

}



