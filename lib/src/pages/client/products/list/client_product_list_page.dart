import 'package:delivery_app/src/pages/client/products/list/client_product_list_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
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
        child: ElevatedButton(
          onPressed: _con.logout,
          child: Text('cerrar sesion'),
        ),
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
                Text(
                  '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}  ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 1,
                ),
                Text(
                  ' ${_con.user?.email ?? ''} ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[300],
                  ),
                  maxLines: 1,
                ),
                Text(
                  ' ${_con.user?.phone ?? ''} ',
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
                    placeholder: AssetImage('assets/img/no-image.png'),
                    image: _con.user?.image != null
                        ? NetworkImage(_con.user!.image!)
                        : AssetImage('assets/img/no-image.png')
                            as ImageProvider,
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: _con.goToUpdatePage,
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          const ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_bag_outlined),
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
