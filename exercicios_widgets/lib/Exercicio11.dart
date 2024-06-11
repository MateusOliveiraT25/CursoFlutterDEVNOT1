import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Básico',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Básico'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text('Container', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: <Widget>[
                  Icon(Icons.android, size: 50),
                  Text('Column'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/flutter_logo.png', width: 50, height: 50),
                  SizedBox(width: 10),
                  Text('Row'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
