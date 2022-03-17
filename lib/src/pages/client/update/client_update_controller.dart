import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  BuildContext? context;
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

    nameController.text = user?.name ?? '';
    lastnameController.text = user?.lastname ?? '';
    phoneController.text = user?.phone ?? '';

    refresh();
  }

  void updatedUser() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }

    _progressDialog?.show(max: 100, msg: 'Espere un momento...');
    isEnabled = false;

    User myUser = new User(
        id: user!.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user!.image);

    Stream stream = await usersProvider.updateUser(myUser, imageFile!);
    stream.listen((res) async {
      _progressDialog!.close();

      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);

      if (responseApi.success) {
        user = await usersProvider
            .getbyID(myUser.id!); // OBTENIENDO EL USUARIO DE LA DB
        print('Usuario obtenido: ${user!.toJson()}');
        _sharedPref.save('user', user!.toJson());
        Navigator.pushNamedAndRemoveUntil(
            context!, 'cliente/product/list', (route) => false);
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
    Navigator.pop(context!);
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
        context: context!,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
