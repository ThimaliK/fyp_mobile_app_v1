import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraInput extends StatefulWidget {
  const CameraInput({Key? key}) : super(key: key);

  @override
  State<CameraInput> createState() => _CameraInputState();
}

class _CameraInputState extends State<CameraInput> {

  File _image = File('assets/logo.png');

  List <File> _images = [];

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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recipe_list',
                        arguments: {'photos': _images});
                  },
                  child: Text('Get Recipes')
              )
              
            ]
          ),

        // body: Center(
        //   child: _image == null ? Text('No image selected') : Image.file(
        //       _image),
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple[700],
          child: Icon(Icons.camera_alt),
          onPressed: () {
            getImage();
          },
        ),

      );

      // return Scaffold(
      //     appBar: AppBar(
      //       title: const Text('Multiple Images'),
      //     ),
      //     body: SafeArea(
      //       child: Column(
      //         children: [
      //           ElevatedButton(
      //             onPressed: () {
      //               selectImages();
      //             },
      //             child: const Text('Select Images'),
      //           ),
      //           Expanded(
      //             child: Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: GridView.builder(
      //                   itemCount: imageFileList!.length,
      //                   gridDelegate:
      //                   const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisCount: 3),
      //                   itemBuilder: (BuildContext context, int index) {
      //                     return Image.file(File(imageFileList![index].path),
      //                       fit: BoxFit.cover,);
      //                   }),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ));
    }

}



