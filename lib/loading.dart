import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void moveToHome() async {
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    moveToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[700],
        body: const Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 50.0,
          ),
        )
    );
  }
}
