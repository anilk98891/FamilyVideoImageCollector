import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Routes/CreateUser.dart';
import 'package:flutter_familyapp/Routes/GetUsersData.dart';
import 'package:flutter_familyapp/Routes/PreviewClassImageVideo.dart';
import 'package:flutter_familyapp/Routes/PreviewVideo.dart';
import 'package:flutter_familyapp/Routes/UploadLoaderRoutes.dart';
import 'package:flutter_familyapp/Routes/UsersScreen.dart';
import 'package:flutter_familyapp/Routes/Welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => Welcome(),
        '/createUser':(context) => CreateUser(),
        '/UserScreen':(context) => UserScreen(),
        '/GetUserData':(context) => GetUserData(),
        '/UploadLoader':(context) => UploadLoader(),
        '/PreviewController':(context) => PreviewController(),
        '/PreviewVideo':(context) => PreviewVideo()
      },
    );
  }
}
