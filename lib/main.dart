import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatoz_map/home.dart';
import 'package:eatoz_map/provider/map_data_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MapDataProvider(),
      child: MaterialApp(
        title: 'Google Map Integration',
        home: Home(),
      ),
    );
  }
}
