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
  SharedPref sharePr = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await userProv.init(context);

    User user = User.fromJson(await sharePr.read('user') ?? {});
    print('Usuario guardado en share  ${user.toJson()}');
    // ignore: unnecessary_null_comparison
    if (user != null) {
      if (user.sessionToken != null) {
        if (user.roles!.length > 1) {
          Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, user.roles![0].route, (route) => false);
        }
      }
    }
  }

  void loginM(BuildContext context) async {
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    ResponseApi resp = await userProv.login(email, password);

    print('valor de la respuesta : ${resp.toJson()}');
    if (resp.success) {
      User user = User.fromJson(resp.data);
      sharePr.save('user', user.toJson());
      print('usuariologueado ${user.toJson()}');
    } else {
      print('el valor del contex es ${context}');
      MySnackbar.show(context, resp.message);
    }
  }
}
