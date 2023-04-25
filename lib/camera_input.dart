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

  //String data = "test";

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

    Widget photosPreview() {
      return GridView.builder(
        itemCount: _images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0
        ),
        itemBuilder: (BuildContext context, int index){
          //
          return
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Image.file(_images[index]),
                IconButton(onPressed: () {
                  print("icon button click");
                  _images.remove(_images[index]);
                  setState(() {

                  });
                },
                  icon: const Icon(Icons.delete),
                  iconSize: 20,
                  alignment: Alignment.bottomRight,
                ),
              ],),
            );
        },
      );
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
                  child: photosPreview()
              ),
            ),
              SizedBox(height: 10.0,),

              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 20),

                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          getImagesFromGallery();
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                        child: const Text('Gallery')
                    ),
                    SizedBox(height: 10.0,),
                    ElevatedButton(
                      onPressed: () {
                        getImage();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                      child: const Text('Camera'),
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
                        style: ElevatedButton.styleFrom(primary: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                        child: Text('Get Recipes')
                    ),
                  ],
                ),
              ),



              
            ]
          ),



      );


    }

}



