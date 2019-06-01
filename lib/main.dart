import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped-models/main.dart';
import './pages/auth.dart';
import './pages/mainpage.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState()
{
  return _MyAppState();
}
}

class _MyAppState extends State<MyApp>{
@override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            // brightness:bright,
            primarySwatch: Colors.blue,
            accentColor: Colors.blueAccent,
            buttonColor: Colors.blueAccent),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/home':(BuildContext context) => MyHomePage(),
          // '/emotions': (BuildContext context) => EmotionsPage(model),
          // '/items': (BuildContext context) => ItemsPage(model)
        },
      ),
    );
  }
}

