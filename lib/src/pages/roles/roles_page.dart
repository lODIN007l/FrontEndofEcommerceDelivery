import 'package:delivery_app/src/models/rol.dart';
import 'package:delivery_app/src/pages/roles/roler_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RolesPage extends StatefulWidget {
  RolesPage({Key? key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = RolesController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Seleccione un ROL'),
          backgroundColor: Colors.redAccent,
        ),
        body: ListView(
          children: _con.user != null
              ? _con.user!.roles!.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : [],
        ));
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        Container(
          height: 100,
          child: FadeInImage(
            placeholder: const AssetImage('assets/img/no-image.png'),
            image: NetworkImage(rol.image!),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 50),
          ),
        ),
        Text(
          rol.name ?? '',
          style: TextStyle(fontSize: 16, color: Colors.black),
        )
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
