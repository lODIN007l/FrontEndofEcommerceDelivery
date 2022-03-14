import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  RolesPage({Key? key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('roles page'),
      ),
    );
  }
}
