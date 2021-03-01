import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Helper/Constants.dart';
import 'package:flutter_familyapp/Model/UserListModel.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserListParent usersListObj;
  List<UsersListModel> usersObj;

  Future<void> apiCallUserList() async {
    dynamic object =  await getUsers(Constants().baseURL + '/users');
    print(object.toString());
    usersListObj = UserListParent.fromJson(object);
    usersObj = usersListObj.userobj;
  }

  Future<dynamic> getUsers(String url) async {
    try {
      Response response = await get(url);
      return (jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiCallUserList(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return usersObj == null ? Container() : Center(
                child: ListView.separated(itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () async {
                      dynamic result = await Navigator.pushNamed(context, '/GetUserData',
                          arguments: {"user": usersObj[i]});
                      if (result != null) {
                        setState(() {
                          usersObj[i] = result;
                        });
                      }
                    },
                    child: ListTile(
                      title: Text(usersObj[i].name),
                    ),
                  );
                }, separatorBuilder: (context, view) {
                  return Container(color: Colors.black, height: 0.3);
                }, itemCount: usersObj.length),
              );
            }else {
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}
