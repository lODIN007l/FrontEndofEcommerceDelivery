import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClienteController {
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

  User? user;
  SharedPref _sharedPref = SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void registroTexto() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes igresar todos los campos');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, 'Porfavor ,Seleccione una imagen');
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento');
    isEnabled = false;

    User user = User(
      name: name,
      lastname: lastname,
      phone: phone,
      // password: password,
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
