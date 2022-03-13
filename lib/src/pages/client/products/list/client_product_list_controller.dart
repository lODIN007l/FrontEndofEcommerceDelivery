import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientListProductControlerr {
  BuildContext? context;
  SharedPref sharPrr = SharedPref();

  Future? init(BuildContext context) {
    this.context = context;
    return null;
  }

  logout() {
    sharPrr.logout(context!);
  }
}
