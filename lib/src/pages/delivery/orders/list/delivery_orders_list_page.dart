import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

DeliveryOrdersListController _con = DeliveryOrdersListController();

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({Key? key}) : super(key: key);

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
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
      key: _con.key,
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        leading: _menudrawer(),
      ),
      body: Center(
        child: Text('Delivery orders list'),
      ),
    );
  }

  Widget _menudrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          height: 20,
          width: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nombre del usuario',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                ),
                Text(
                  'email',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[300],
                  ),
                  maxLines: 1,
                ),
                Text(
                  'Telefono',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[300],
                  ),
                  maxLines: 1,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 60,
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/img/no-image.png'),
                    image: const AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                  ),
                )
              ],
            ),
          ),
          _con.user != null
              ? _con.user!.roles!.length > 1
                  ? ListTile(
                      onTap: _con.gotoRoles,
                      title: const Text(' Seleccionar Rol'),
                      trailing: const Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar Sesion'),
            trailing: const Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
