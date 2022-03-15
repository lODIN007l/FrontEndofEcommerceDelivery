import 'package:delivery_app/src/pages/client/products/list/client_product_list_page.dart';
import 'package:delivery_app/src/pages/client/update/client_update_page.dart';
import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_app/src/pages/login/login_page.dart';
import 'package:delivery_app/src/pages/register/registro_page.dart';
import 'package:delivery_app/src/pages/restaurante/orders/list/restaurante_orders_list.dart';
import 'package:delivery_app/src/pages/roles/roles_page.dart';
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
        'roles': (BuildContext context) => RolesPage(),
        'cliente/update': (BuildContext context) => ClienUpdatePage(),
        'cliente/product/list': (BuildContext context) =>
            ClienteProductListPage(),
        'restaurante/orders/list': (BuildContext context) =>
            RestuaranteOrdersList(),
        'delivery/orders/list': (BuildContext context) =>
            DeliveryOrdersListPage(),
      },
      theme: ThemeData(
        fontFamily: 'NumbusSans',
        primaryColor: Colors.amberAccent,
      ),
    );
  }
}
