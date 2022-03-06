import 'package:delivery_app/src/pages/client/products/list/client_product_list_page.dart';
import 'package:delivery_app/src/pages/login/login_page.dart';
import 'package:delivery_app/src/pages/register/registro_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App ',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'cliente/product/list': (BuildContext context) =>
            ClienteProductListPage(),
      },
      theme: ThemeData(
        fontFamily: 'NumbusSans',
        primaryColor: Colors.amberAccent,
      ),
    );
  }
}
