import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Custom/CustomAlert.dart';
import 'package:flutter_familyapp/Helper/Constants.dart';
import 'package:flutter_familyapp/Model/UserListModel.dart';
import 'package:flutter_familyapp/Routes/CreateUser.dart';
import 'package:flutter_familyapp/Routes/PreviewClassImageVideo.dart';
import 'package:http/http.dart' as http;

class GetUserData extends StatefulWidget {
  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  UsersListModel usersObj;

  void apiCall() async {
    print(this.usersObj.id);
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = Constants().baseURL + '/users/user_delete/${this.usersObj.id}';
    var response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      Navigator.popAndPushNamed(context, '/');
    }
  }
  void onBackPressed() {
    print("back");
    Navigator.pop(context,usersObj);
  }
  
  @override
  Widget build(BuildContext context) {
    final routes =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (routes != null) {
      usersObj = routes["user"];
    }
    return new WillPopScope( //on system pressed back button create action
      onWillPop: () async {
        Navigator.pop(context,usersObj);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: onBackPressed,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PreviewController(
                              previewTypeObj: previewType.video,
                              usersObj: usersObj,
                            )))
                  },
                  child: ListTile(
                    title: Text(
                      'Videos',
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PreviewController(
                          previewTypeObj: previewType.image,
                          usersObj: usersObj,
                        )))
                  },
                  child: ListTile(
                    title: Text(
                      'Images',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                   dynamic result = await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateUser(
                          usersObj: usersObj,
                        )));
                   if (result != null) {
                     setState(() {
                       usersObj = result;
                     });
                   }
                  },
                  child: ListTile(
                    title: Text(
                      'Update Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, '/UploadLoader',
                        arguments: {"user": usersObj})
                  },
                  child: ListTile(
                    title: Text(
                      'Upload',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => {
                    CustomAlert().showAlertDialog(context, "Are you sure ?", "Delete user", "Delete", "Cancel" ,(val) {
                      if (val == "delete") {
                        apiCall();
                      }
                    })
                  },
                  child: ListTile(
                    title: Text(
                      'Delete User',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
