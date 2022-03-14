import 'package:flutter/material.dart';

class RestuaranteOrdersList extends StatefulWidget {
  RestuaranteOrdersList({Key? key}) : super(key: key);

  @override
  State<RestuaranteOrdersList> createState() => _RestuaranteOrdersListState();
}

class _RestuaranteOrdersListState extends State<RestuaranteOrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Restaurante orders list'),
      ),
    );
  }
}
