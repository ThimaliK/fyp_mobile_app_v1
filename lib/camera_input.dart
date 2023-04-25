import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'api/api_service.dart';



class CameraInput extends StatefulWidget {
  const CameraInput({Key? key}) : super(key: key);

  @override
  State<CameraInput> createState() => _CameraInputState();
}

class _CameraInputState extends State<CameraInput> {

  File _image = File('assets/logo.png');

  final List <File> _images = [];

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

    }

    Future getImagesFromGallery() async {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image!.path);
        _images.add(_image);
        //getImage();
      });

    }


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


                        Navigator.pushNamed(context, '/recipe_list',
                        arguments: {'photos': _images})

                      }
                    });

                    print('foodRecognitionStatus - $foodRecognitionStatus');
                  },
                  child: Text('Get Recipes')
              ),

              
            ]
          ),



      );


    }

}



