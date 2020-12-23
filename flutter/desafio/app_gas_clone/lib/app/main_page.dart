import 'package:app_gas_clone/app/pages/buy_page.dart';
import 'package:app_gas_clone/app/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        BuyPage.routeName: (_) {
          var revenda = ModalRoute.of(_).settings.arguments;
          return BuyPage(revenda: revenda);
        },
      },
    );
  }
}
