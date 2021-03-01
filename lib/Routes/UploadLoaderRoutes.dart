import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Model/UserListModel.dart';
import 'package:flutter_familyapp/Helper/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadLoader extends StatefulWidget {
  @override
  _UploadLoaderState createState() => _UploadLoaderState();
}

class _UploadLoaderState extends State<UploadLoader> {
  UsersListModel usersObj;
  File imageResized;
  String photoBase64;
  dynamic imageGet;

  Future getVideo(ImageSource source) async {
    var photo = await ImagePicker.pickVideo(source: source);
    apiCallUpload(photo);
  }

  Future getImage(ImageSource source) async {
    var photo = await ImagePicker.pickImage(source: source);
    apiCallUploadImage(photo);
  }

  void apiCallUpload(File source) async {
    var url = Constants().baseURL + '/video/video_create';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'user_id': this.usersObj.id.toString()});
    request.files.add(await http.MultipartFile.fromPath('video', source.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  void apiCallUploadImage(File source) async {
    var url = Constants().baseURL + '/image/images_create';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'user_id': this.usersObj.id.toString()});
    request.files.add(await http.MultipartFile.fromPath('image', source.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.pop(context);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (routes != null) {
      usersObj = routes["user"];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploader'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {
                  getVideo(ImageSource.gallery)
                },
                child: ListTile(
                  title: Text(
                    'Upload Videos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => {
                  getImage(ImageSource.gallery)
                },
                child: ListTile(
                  title: Text(
                    'Upload Images',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
