import 'dart:convert';

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
}
