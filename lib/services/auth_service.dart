import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAcYr-duQ14j-dHPJaH8-b41A4DMjnVEVo';

  // Si se retorna algo, es un error, de lo contrario todo bien
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // Token guardarlo en un lugar seguro
      // return decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }
}
