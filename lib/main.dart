import 'package:aplicacion_videos/widgets/widget_containerlist.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Menu(),
    );
  }
}
