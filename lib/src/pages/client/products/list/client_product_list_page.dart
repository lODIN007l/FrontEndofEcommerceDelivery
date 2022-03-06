import 'package:flutter/material.dart';

class ClienteProductListPage extends StatefulWidget {
  ClienteProductListPage({Key? key}) : super(key: key);

  @override
  State<ClienteProductListPage> createState() => _ClienteProductListPageState();
}

class _ClienteProductListPageState extends State<ClienteProductListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Lista de productos ')),
    );
  }
}
