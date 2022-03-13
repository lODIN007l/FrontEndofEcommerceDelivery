import 'package:delivery_app/src/pages/client/products/list/client_product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

ClientListProductControlerr _con = ClientListProductControlerr();

class ClienteProductListPage extends StatefulWidget {
  ClienteProductListPage({Key? key}) : super(key: key);

  @override
  State<ClienteProductListPage> createState() => _ClienteProductListPageState();
}

class _ClienteProductListPageState extends State<ClienteProductListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _con.logout,
          child: Text('cerrar sesion'),
        ),
      ),
    );
  }
}
