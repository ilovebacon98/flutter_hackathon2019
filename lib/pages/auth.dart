import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/maxresdefault.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'E-Mail', filled: true, fillColor: Colors.white),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextController,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        onSaved: (String value) {
          _formData['email'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm Password',
            filled: true,
            fillColor: Colors.white),
        obscureText: true,
        validator: (String value) {
          if (_passwordTextController.text != value) {
            return 'Password does not match!';
          }
        },
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Password', filled: true, fillColor: Colors.white),
        obscureText: true,
        controller: _passwordTextController,
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return 'Password invalid';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  Widget _buildUserIdTextField() {
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'UserId', filled: true, fillColor: Colors.white),
          validator: (String value) {
            if (value.isEmpty || value.length < 6) {
              return 'UserId invalid';
            }
          },
          onSaved: (String value) {
            _formData['UserId'] = value;
          },
        ));
  }

  Widget _buildNameTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'FullName', filled: true, fillColor: Colors.white),
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return 'Full Name invalid';
          }
        },
        onSaved: (String value) {
          _formData['FullName'] = value;
        },
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login, Function signup) async {
    if (_authMode == AuthMode.Signup) {
      if (!_formKey.currentState.validate() ||
          _formData['acceptTerms'] == false) {
        return;
      }
    }

    _formKey.currentState.save();
    if (_authMode == AuthMode.Login) {
      String authen = login(_formData['UserId'], _formData['password']);
      if (authen != "no") {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('UserId or Password Wrong!'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } else {
      final Map<String, dynamic> successInformation = await signup(
          _formData['UserId'],
          _formData['password'],
          _formData['FullName'],
          _formData['email']);
      if (successInformation['success']) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'FlutterCommunity',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Oswald'),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                    _buildUserIdTextField(),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    _authMode == AuthMode.Signup
                        ? _buildEmailTextField()
                        : Container(),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    _authMode == AuthMode.Signup
                        ? _buildNameTextField()
                        : Container(),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    _buildPasswordTextField(),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    _authMode == AuthMode.Signup
                        ? _buildAcceptSwitch()
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Login
                        ? FlatButton(
                            child: Text(
                                '${_authMode == AuthMode.Login ? 'Sign up' : 'Login'}'),
                            onPressed: () {
                              setState(() {
                                _authMode = _authMode == AuthMode.Login
                                    ? AuthMode.Signup
                                    : AuthMode.Login;
                              });
                            },
                          )
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return RaisedButton(
                          textColor: Colors.white,
                          child: Text(
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'),
                          onPressed: () =>
                              _submitForm(model.login, model.signup),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
