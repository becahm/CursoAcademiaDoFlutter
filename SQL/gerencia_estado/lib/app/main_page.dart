import 'package:flutter/material.dart';
import 'package:gerencia_estado/app/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
