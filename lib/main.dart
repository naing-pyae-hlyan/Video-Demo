import 'package:VideoPlayer/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Video Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity),
    home: HomePage(),
  ));
}
