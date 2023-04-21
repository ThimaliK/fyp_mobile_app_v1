import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'package:fyp_mobile_app_v1/recipe.dart';
import 'package:fyp_mobile_app_v1/recipe_collection.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api/api_service.dart';



class CameraInput extends StatefulWidget {
  const CameraInput({Key? key}) : super(key: key);

  @override
  State<CameraInput> createState() => _CameraInputState();
}

class _CameraInputState extends State<CameraInput> {

  File _image = File('assets/logo.png');

  List <File> _images = [];

  String data = "test";

  String foodRecognitionStatus = "";

  late List <FoodResponseModel> recipes;

  //
  final imagePicker = ImagePicker();

  //


  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      _images.add(_image);
      //getImage();
    });

    //final ImagePicker imgpicker = ImagePicker();
    //List<XFile>? imagefiles;

    //var pickedfiles = await imgpicker.pickMultiImage();



    // if (pickedfiles != null) {
    //   imagefiles = pickedfiles;
    //   setState(() {});
    // } else {
    //   print("No image is selected.");
    // }

    //final ImagePicker imagePicker = ImagePicker();
    //List<XFile>? imageFileList = [];

    // void selectImages() async {
    //   final List<XFile> selectedImages = await
    //   imagePicker.pickMultiImage();
    //   if (selectedImages.isNotEmpty) {
    //     imageFileList!.addAll(selectedImages);
    //   }
    //   print("Image List Length:${imageFileList!.length}");
    //   setState((){});
    // }
    }

    Future getImagesFromGallery() async {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
        _images.add(_image);
        //getImage();
      });

    }


  // var streamedResponse = await request.send();
  // final responseData = await streamedResponse.stream.toBytes();
  // final responseString = String.fromCharCodes(responseData);


    //final List<File> _image = [];
    // Future uploadImages(String url) async {
    //
    //   var request = http.MultipartRequest('POST', Uri.parse(url));
    //
    //
    //   if (_images.length > 0) {
    //     for (var i = 0; i < _images.length; i++) {
    //       request.files.add(http.MultipartFile('files[]',
    //           File(_images[i].path).readAsBytes().asStream(), File(_images[i].path).lengthSync(),
    //           filename: _images[i].path));
    //     }
    //
    //     // send
    //     var response = await request.send();
    //
    //     final responseData = await response.stream.toBytes();
    //     final responseString = String.fromCharCodes(responseData);
    //
    //     // var obj = json.decode(responseString);
    //     //
    //     // Recipe recipe = Recipe.fromJson(obj[0]);
    //     //
    //     // debugPrint(recipe.country);
    //
    //     // RecipeCollection recipeList = RecipeCollection.fromJson(obj);
    //     //
    //     // debugPrint(recipeList.recipeList.first.country);
    //
    //
    //
    //
    //     // listen for response
    //     // response.stream.transform(utf8.decoder).listen((value) {
    //     //   debugPrint(value);
    //     //
    //     // });
    //   }
    //
    //
    // }







    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Take photos of Ingredients'),
          backgroundColor: Colors.deepPurple[700],
          centerTitle: true,
        ),
          body: Column(
            children: <Widget> [Expanded(
              child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: GridView.builder(
                    itemCount: _images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return Image.file(_images[index]);
                    },
                  )),
            ),
              SizedBox(height: 10.0,),
              Text(data),
              SizedBox(height: 10.0,),
              ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text('Camera')
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                  onPressed: () {
                    getImagesFromGallery();
                  },
                  child: Text('Gallery')
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                  onPressed: () {

                    //List<File> images = _images;

                    setState(() {

                    });

                    APIService apiService = APIService();

                    print('api service created');

                    apiService.foodRecognition(_images).then((value) => {
                      if(value.isNotEmpty && value=="top_5_recipes retrieved") {
                        //if(value == "done") {

                        // print(value),
                        //
                        // //foodRecognitionStatus = value,
                        //
                        //
                        //
                        // setState(() {
                        //
                        // })
                        // Navigator.pushNamed(context, '/recipe_list',
                        //     arguments: {'photos': images})
                        // // } else {
                        // //   print("wrong --- $value")
                        // // }

                        Navigator.pushNamed(context, '/recipe_list',
                        arguments: {'photos': _images})

                      }
                    });

                    print('foodRecognitionStatus - $foodRecognitionStatus');


                    // apiService.getBestMatchedRecipes().then((value) => {
                    //
                    //   print('INGREDIENTS - ${value.first.ingredients}'),
                    //
                    //
                    //
                    //   setState(() {
                    //
                    //   }),
                    //
                    //   setState(() {
                    //
                    //   }),
                    //
                    // // Navigator.pushNamed(context, '/recipe_list',
                    // // arguments: {'photos': _images, 'recipe_data': _recipes})
                    //
                    //
                    //
                    // });

                    //var x = apiService.getBestMatchedRecipes();







                    //getRequest();
                    //uploadImages('https://b464-2a00-23c4-f79c-c001-1df0-6241-9c78-7cc9.ngrok-free.app/recognise_ingredients');
                    //postData();
                    // Navigator.pushNamed(context, '/recipe_list',
                    //     arguments: {'photos': _images});
                  },
                  child: Text('Get Recipes')
              ),

              
            ]
          ),



      );


    }

}



