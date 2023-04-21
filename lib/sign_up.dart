import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/signup_model.dart';
import 'package:fyp_mobile_app_v1/recipe.dart';
import 'package:fyp_mobile_app_v1/recipe_collection.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'api/api_service.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

// Future<Object> createUser(String username, String email, String password, String country, String birthdate, String foodPrefs) async {
//
//   try {
//
//     print("1-------------------------");
//     final response = await http.post(
//       Uri.parse('http://10.0.2.2:5000/sign_up'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'email': email,
//         'password': password,
//         'country': country,
//         'birth_date': birthdate,
//         'food_preferences': foodPrefs,
//       }),
//     );
//
//     print("2-------------------------");
//
//     print("status code${response.statusCode}");
//
//     return response;
//   }
//
//   catch (e){
//     print("exception-------------------------");
//     print(e);
//
//     return "string";
//   }
//
//
// }





class _SignUpState extends State<SignUp> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final foodPrefController = TextEditingController();

  String selectedCountry = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    foodPrefController.dispose();
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
      foodPrefController.text
    );


  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a new Account'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                    ),
                    controller: usernameController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email',

                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter password',
                    ),
                    controller: passwordController,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Enter password',
                    ),
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
                            selectedCountry = country.displayName;
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
                    child: Text('Country: $selectedCountry'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Food Preferences',
                      hintText: 'Enter your food preferences',
                    ),
                    controller: foodPrefController,
                  ),
                ),
                ElevatedButton(
                  child: const Text('Create Account'),
                  onPressed: (){
                     // String username = usernameController.text;
                     // String email = emailController.text;
                     // String password = passwordController.text;
                     // String birthDate = "12/12/2000";
                     // String foodPreferences = foodPrefController.text;

                    requestModel.username = usernameController.text;
                    requestModel.email = emailController.text;
                    requestModel.password = passwordController.text;
                    requestModel.country = selectedCountry;
                    requestModel.birthDate = "12/12/2000";
                    requestModel.foodPreferences = foodPrefController.text;

                     setState(() {

                     });

                    print(requestModel.toJson());

                    APIService apiService = APIService();

                    print('api service created');

                    apiService.register(requestModel).then((value) => {
                      if(value.response.isNotEmpty) {
                        if(value.response == "registration successful") {
                          Navigator.pushNamed(context, '/')
                        } else {
                          print("wrong${value.response}")
                        }
                      }
                    });





                     //var response = createUser(username, email, password, selectedCountry, birthDate, foodPreferences);

                     //print("response------------------------------------------------------------------");
                     //print(response.toString());


                     //Navigator.pushNamed(context, '/');


                  },
                ),

              ],
            )
        )
      );


  }

}



