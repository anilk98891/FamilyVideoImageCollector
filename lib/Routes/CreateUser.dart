import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Helper/Constants.dart';
import 'package:flutter_familyapp/Model/UserListModel.dart';
import 'package:http/http.dart' as http;

class CreateUser extends StatefulWidget {
  UsersListModel usersObj;

  CreateUser({this.usersObj});

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final nameTF = TextEditingController();
  final ageTF = TextEditingController();
  final intrestTF = TextEditingController();
  final statusTF = TextEditingController();
  final constantClass = Constants();

  void createUser() {
    apiCall();
  }

  void uiSetup() {
    nameTF.text = widget.usersObj.name;
    ageTF.text = widget.usersObj.age.toString();
    intrestTF.text = widget.usersObj.intrests;
    statusTF.text = widget.usersObj.status;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.usersObj != null) {
      this.uiSetup();
    }
    super.initState();
  }

  void apiCallUpdate() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = constantClass.baseURL + '/users/user_edit';
    var response = await http.put(url,
        headers: headers,
        body:
            '{"name": "${this.nameTF.text}", "age": "${this.ageTF.text}","intrests":"${this.intrestTF.text}","status":"${this.statusTF.text}","id":"${this.widget.usersObj.id}"}');
    if (response.statusCode == 200) {
      widget.usersObj.status = this.statusTF.text;
      widget.usersObj.name = this.nameTF.text;
      widget.usersObj.age = this.ageTF.text;
      widget.usersObj.intrests = this.intrestTF.text;
      Navigator.pop(context,widget.usersObj);
    }
  }

  void apiCall() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = constantClass.baseURL + '/users/user_create';
    var response = await http.post(url,
        headers: headers,
        body:
        '''{\n    "intrests":"${this.intrestTF.text}",\n    "status":"${this.statusTF.text}",\n    "age":${this.ageTF.text},\n    "name":"${this.nameTF.text}"\n}''');
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            widget.usersObj == null ? Text('Create user') : Text('Update user'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.blue,
                  controller: nameTF,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: "Name",
                    helperText: "Enter name",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    helperStyle: TextStyle(fontSize: 12.0, color: Colors.red),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.number,
                  controller: ageTF,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: "AGE",
                    helperText: "Enter AGE",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    helperStyle:
                        TextStyle(fontSize: 12.0, color: Colors.redAccent),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.blue,
                  controller: intrestTF,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: "Intrest",
                    helperText: "Your intrests",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    helperStyle:
                        TextStyle(fontSize: 12.0, color: Colors.redAccent),
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  style: TextStyle(fontSize: 20),
                  cursorColor: Colors.blue,
                  controller: statusTF,
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: "Status",
                    helperText: "Enter Marital Status",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    helperStyle:
                        TextStyle(fontSize: 12.0, color: Colors.redAccent),
                  ),
                ),
                OutlineButton(
                  onPressed: () => {
                    widget.usersObj != null ? apiCallUpdate() : createUser()
                  },
                  borderSide: BorderSide(color: Colors.blue, width: 1),
                  shape: StadiumBorder(),
                  child: Text(
                    widget.usersObj == null ? 'Create' : "Update",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20.0,
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
