import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/models/food_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          //mainAxisSpacing: 2.0,
        mainAxisExtent: 225
      ),
      itemBuilder: (BuildContext context, int index){
        //
        return
          SingleChildScrollView(

            child: 
            
            Container(

              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 2,),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(_images[index]),
                  IconButton(
                    onPressed: () {
                    //print("icon button click");
                    _images.remove(_images[index]);
                    setState(() {

                    });
                  },
                    icon: const Icon(Icons.delete, color: Colors.black54,),
                    iconSize: 25,
                    alignment: Alignment.center,
                    
                  ),
                ],),
            ),
          );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take photos of Ingredients'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
          children: <Widget> [
            Expanded(

            child: Container(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: photosPreview()
            ),
          ),
            const SizedBox(height: 10.0,),

            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),

              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            getImagesFromGallery();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70, maximumSize: const Size.fromHeight(50),
                              side: const BorderSide(
                                  width: 1, // the thickness
                                  color: Colors.black // the color of the border
                              )

                          ),

                              child: const Text('Gallery', style: TextStyle(color: Colors.black),)
                      ),
                      //SizedBox(height: 10.0,),
                      const SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          getImage();
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70, maximumSize: const Size.fromHeight(50),
                          shadowColor: Colors.black,
                            side: const BorderSide(
                                width: 1, // the thickness
                                color: Colors.black // the color of the border
                            )
                        ),
                        child: const Text('Camera', style: TextStyle(color: Colors.black),),
                      ),
                      //SizedBox(height: 10.0,),

                    ],
                  ),

                  const SizedBox(height: 15,),

                  ElevatedButton(
                      onPressed: () {

                        if(_images.isNotEmpty) {

                          setState(() {

                          });

                          APIService apiService = APIService();

                          //print('api service created');

                          apiService.foodRecognition(_images).then((value) => {
                            if(value.isNotEmpty && value=="top_5_recipes_retrieved") {

                              Navigator.pushNamed(context, '/recipe_list',
                                  arguments: {'photos': _images})
                            }
                          });

                          //print('foodRecognitionStatus - $foodRecognitionStatus');

                        }


                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple, maximumSize: const Size.fromHeight(50)),
                      child: const Text('Find Recipes')
                  ),
                ],
              ),
            ),
          ]
      ),



    );


  }

}

