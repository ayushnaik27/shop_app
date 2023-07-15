import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return (_token != null);
  }

  String? get token {
    if (_token != '' && _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    ;
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD3KRxSmR1sjPnFusKjKJSyoBZsM4vDB3k');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['error'] != null &&
          responseData['error']['message'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD3KRxSmR1sjPnFusKjKJSyoBZsM4vDB3k');
    // final response = await http.post(
    //   url,
    //   body: json.encode({
    //     'email': email,
    //     'password': password,
    //     'returnSecureToken': true,
    //   }),
    // );
    // // print(json.decode(response.body));
    return authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD3KRxSmR1sjPnFusKjKJSyoBZsM4vDB3k');
    // final response = await http.post(
    //   url,
    //   body: {
    //     'email': email,
    //     'password': password,
    //     'returnSecureToken': true.toString(),
    //   },
    // );
    // print(json.encode(response.body));
    return authenticate(email, password, 'signInWithPassword');
  }
}

//Have to learn about proxyprovider
