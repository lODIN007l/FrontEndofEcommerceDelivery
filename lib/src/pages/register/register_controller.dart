import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterControleer {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassswordController = TextEditingController();
  late BuildContext context;
  UsersProvider usersProvider = UsersProvider();
  PickedFile? picketF;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;
  bool isEnabled = true;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
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

    if (imageFile == null) {
      MySnackbar.show(context, 'Porfavor ,Seleccione una imagen');
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento');
    isEnabled = false;

    User user = User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password,
    );

    Stream stream = await usersProvider.createwithImage(user, imageFile!);
    stream.listen((res) {
      _progressDialog!.close();
      //ResponseApi responseApi = await UsersProvider().create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print(responseApi.toJson());
      MySnackbar.show(context, responseApi.message);
      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      } else {
        isEnabled = true;
      }
    });
  }

  Future selectImagen(ImageSource imagenSource) async {
    picketF = await ImagePicker().getImage(source: imagenSource);
    if (picketF != null) {
      imageFile = File(picketF!.path);
    }
    Navigator.pop(context);
    refresh!();
  }

  void showAlertDialog() {
    Widget gallerybuton = ElevatedButton(
        onPressed: () {
          selectImagen(ImageSource.gallery);
        },
        child: Text('Galeria'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImagen(ImageSource.camera);
        },
        child: const Text('Camara'));
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [
        gallerybuton,
        cameraButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
