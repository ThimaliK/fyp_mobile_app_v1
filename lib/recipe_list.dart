import 'package:flutter/material.dart';
import 'dart:io';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {

  Map data = {};

  @override

  Widget build(BuildContext context) {

    if (data.isNotEmpty) {
      data = data;
    } else {
      data = ModalRoute.of(context)?.settings.arguments as Map;
    }

    List <File> _images = data['photos'];
    

    return Scaffold(
      appBar: AppBar(title: Text('recipe list')),
      body: SafeArea(
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
    );
  }

}
