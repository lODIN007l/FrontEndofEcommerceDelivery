import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class RestauranteOrdersListController {
  BuildContext? context;
  SharedPref sharPrr = SharedPref();
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharPrr.read('user'));
    refresh();
    return null;
  }

  void logout() {
    sharPrr.logout(context!);
  }

  void openDrawer() {
    //key.currentState!.openDrawer();
  }

  void gotoRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}
