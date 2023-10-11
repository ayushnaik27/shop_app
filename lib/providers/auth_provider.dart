import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';
  Timer authTimer = Timer(Duration.zero, () {});

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return (_token != '');
  }

  String? get token {
    if (_token != '' && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }

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
      // print(responseData);
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
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userId': _userId,
        'token': _token,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = '';
    _userId = '';
    _expiryDate = DateTime.now();
    if (authTimer != Timer(Duration.zero, () {})) {
      authTimer.cancel();
      authTimer = Timer(Duration.zero, () {});
    }
    notifyListeners();
    final prefs= await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    if (authTimer != Timer(Duration.zero, () {})) {
      authTimer.cancel();
    }

    int timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedData = json.decode(prefs.getString('userData').toString())
        as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedData['idToken'];
    _userId = extractedData['localId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
}

//Have to learn about proxyprovider



