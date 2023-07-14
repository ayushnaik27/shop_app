import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1),
                  Color.fromRGBO(255, 188, 117, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1]),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1, child: AuthCard())
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authmode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authmode == AuthMode.Login) {
        //Log User In
        await Provider.of<Auth>(context, listen: false).logIn(
            _authData['email'].toString(), _authData['password'].toString());
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        //Sign User Up
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['email'].toString(), _authData['password'].toString());
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.message.contains('EMAIL_EXISTS')) {
        errorMessage = 'Email already exists';
      } else if (error.message.contains('INVALID_EMAIL')) {
        errorMessage = 'Please enter valid email';
      } else if (error.message.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'No user found registered to this email';
      } else if (error.message.contains('WEAK_PASSWORD')) {
        errorMessage = 'Please enter a strong password';
      } else if (error.message.contains('INVALID_PASSWORD')) {
        errorMessage = 'Please enter correct password';
      }
      _showErrorDialog(errorMessage);
     } 
    // DON'T KNOW WHHY THIS ISN'T WORKING
     catch (error) {
      print(error.toString());
      const errorMessage =
          'There might be some server issues. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authmode == AuthMode.Login) {
      setState(() {
        _authmode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authmode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authmode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authmode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid Email!';
                  }
                },
                onSaved: (newValue) {
                  _authData['email'] = newValue.toString();
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (newValue) {
                  _authData['password'] = newValue.toString();
                },
              ),
              if (_authmode == AuthMode.Signup)
                TextFormField(
                  enabled: _authmode == AuthMode.Signup,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: _authmode == AuthMode.Signup
                      ? (value) {
                          if (value.toString() != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                  onSaved: (newValue) {
                    _authData['password'] = newValue.toString();
                  },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  child:
                      Text(_authmode == AuthMode.Signup ? 'SIGNUP' : 'LOGIN'),
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                    '${_authmode == AuthMode.Signup ? 'LOGIN' : 'SIGNUP'} INSTEAD'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
