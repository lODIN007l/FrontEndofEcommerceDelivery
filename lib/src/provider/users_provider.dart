import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:delivery_app/src/api/enviroment.dart';
import 'package:delivery_app/src/models/responde_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';
  late BuildContext context;

  Future? init(BuildContext context) {
    this.context = context;
    print('inicio del context');
  }

  Future<ResponseApi> create(User user) async {
    Uri url = Uri.http(_url, '$_api/create');
    String bodyParams = json.encode(user);
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    print(res.body.toString());
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
  }

  Future<Stream> createwithImage(User user, File imagenFile) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      if (imagenFile != null) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(imagenFile.openRead().cast()),
            await imagenFile.length(),
            filename: basename(imagenFile.path)));
      }
      request.fields['user'] = json.encode(user);
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error : ${e}');
      return null!;
    }
  }

  Future<Stream> updateUser(User user, File imagenFile) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);
      if (imagenFile != null) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(imagenFile.openRead().cast()),
            await imagenFile.length(),
            filename: basename(imagenFile.path)));
      }
      request.fields['user'] = json.encode(user);
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error : ${e}');
      return null!;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    Uri url = Uri.http(_url, '$_api/login');
    String bodyParams = json.encode({'email': email, 'password': password});
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    print(res.body.toString());
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;

    // ignore: avoid_print
  }

  Future<User> getbyID(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findbyID/$id');
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.get(url, headers: headers);
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error :  ${e}');
      return null!;
    }
  }
}
