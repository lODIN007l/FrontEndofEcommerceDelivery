import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class Logincontroller {
  BuildContext? context;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  UsersProvider userProv = UsersProvider();
  SharedPref _sharePr = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;

    await userProv.init(context);
  }

  void loginM(BuildContext context) async {
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    ResponseApi resp = await userProv.login(email, password);

    print('valor de corre $email y el de pass es : $password');
    print('valor de la respuesta : ${resp.toJson()}');
    if (resp.success) {
      User user = User.fromJson(resp.data);
      _sharePr.save('user', user.toJson());

      Navigator.pushNamedAndRemoveUntil(
          context, 'cliente/product/list', (route) => false);
    } else {
      print('el valor del contex es ${context}');
      MySnackbar.show(context, resp.message);
    }
  }
}
