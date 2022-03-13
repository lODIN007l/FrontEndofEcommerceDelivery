import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterControleer {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassswordController = TextEditingController();
  late BuildContext context;
  UsersProvider usersProvider = UsersProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;

    usersProvider.init(context);
  }

  void registroTexto() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPassswordController.text.trim();
    if (email.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes igresar todos los campos');
      return;
    }

    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
          context, 'La contraseña debe tener al menos 6 caracteres');
    }

    User user = User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
    );
    ResponseApi responseApi = await UsersProvider().create(user);
    //ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
    print(responseApi.toJson());
    MySnackbar.show(context, responseApi.message);
    if (responseApi.success) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }
  }
}
