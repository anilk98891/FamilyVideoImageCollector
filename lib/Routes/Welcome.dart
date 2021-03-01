import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/UserScreen')
                },
                borderSide: BorderSide(color: Colors.blue, width: 1),
                shape: StadiumBorder(),
                child: Text(
                  'Get Family Users',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 30),
              OutlineButton(
                onPressed: () => {Navigator.pushNamed(context, '/createUser')},
                borderSide: BorderSide(color: Colors.blue, width: 1),
                shape: StadiumBorder(),
                child: Text(
                  'Create Family Users',
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
    );
  }
}
