import 'package:flutter/material.dart';
import 'package:fyp_mobile_app_v1/loading.dart';
import 'package:fyp_mobile_app_v1/home.dart';
import 'package:fyp_mobile_app_v1/camera_input.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const Home(),
    '/home': (context) => const Home(),
    '/camera_input': (context) => const CameraInput(),
  },
));
