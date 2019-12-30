import 'package:boom_finder_dev/constants/auth.dart';
import 'package:boom_finder_dev/models/authentication.dart';
import 'package:boom_finder_dev/scoped_models/Application.dart';
import 'package:boom_finder_dev/views/animation/animated-wave-stack.dart';
import 'package:boom_finder_dev/views/utils/DialogUtils.dart';
import 'package:boom_finder_dev/views/widgets/textField/FilledBorderTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final databaseReference = Firestore.instance;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Auth auth = Auth();
  final _formKey = new GlobalKey<FormState>();
  String _username, _password, _errorMessage = '', _address, _name, _phone;
  bool isShowPW = false;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });

    if (validateAndSave()) {
      try {
        AuthConstants.userId = await auth.signUp(_username, _password);
        await Firestore.instance.collection('user').add({
          'email' : _username,
          'name': _name,
          'phonenumber': _phone,
          'address': _address
        });

        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        print('Signed up user: ${AuthConstants.userId}');

        if (AuthConstants.userId != null &&
            AuthConstants.userId.length > 0) {
          Navigator.pushNamed(context, '/');
        } else {
          showWarningAlert(description: 'Username or password was wrong', title: 'Wrong', context: context);
        }
      } catch (e) {
        print('Error: $e');
        showWarningAlert(description: 'Username or password was wrong', title: 'Wrong', context: context);
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
          width: 350,
          height: 600,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Register Boom Finder User',
                    style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black87,
                              Colors.black54,
                              Colors.black45
                            ],
                          ).createShader(Rect.fromLTWH(40.0, 5.0, 250.0, 4.0)),
                        decorationThickness: 2),
                  ),
                ),
                FilledBorderTextField(
                  hintText: 'Your Name',
                  suffixIcon: Icon(
                      Icons.person_pin
                  ),
                  validator: (value) =>
                  value.isEmpty ? 'Name can\'t be empty' : null,
                  onSave: (String val) {
                    _name = val;
                  },
                  type: TextInputType.text,
                  fill: Colors.white,
                ),
                FilledBorderTextField(
                  hintText: 'Your address',
                  suffixIcon: Icon(
                      Icons.map
                  ),
                  validator: (value) => value.isEmpty ? 'Adrres can\'t be empty' : null,
                  onSave: (String val) {
                    _address = val;
                  },
                  type: TextInputType.text,
                  fill: Colors.white,
                ),
                FilledBorderTextField(
                  hintText: 'Your phone number',
                  suffixIcon: Icon(
                      Icons.phone,
                    color: Colors.green,
                  ),
                  validator: (value) => value.isEmpty ? 'Phone can\'t be empty' : null,
                  onSave: (String val) {
                    _phone = val;
                  },
                  type: TextInputType.number,
                  fill: Colors.white,
                ),

                FilledBorderTextField(
                  validator: (String text) {
                    if (text.isEmpty)
                      return 'Username cannot be empty';
                    else if (text.contains(' '))
                      return 'Username cannot contain emptyspace';
                    else if (text.length < 6)
                      return 'Name must be more than 6 charater';
                    else
                      return null;
                  },
                  hintText: 'Your Username',
                  suffixIcon: Icon(Icons.people),
                  onSave: (String val) {
                    _username = val;
                  },
                  fill: Colors.white,
                  type: TextInputType.emailAddress,
                ),
                FilledBorderTextField(
                  hintText: 'Your password',
                  suffixIcon: Icon(
                    isShowPW ? Icons.panorama_fish_eye : Icons.remove_red_eye,
                  ),
                  onPressSuffixIcon: () {
                    setState(() {
                      isShowPW = !isShowPW;
                    });
                  },
                  validator: (value) =>
                  value.isEmpty ? 'Password can\'t be empty' : null,
                  onSave: (String val) {
                    _password = val;
                  },
                  isPassword: !isShowPW,
                  type: TextInputType.visiblePassword,
                  fill: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.blue,
                        minWidth: 120,
                        onPressed: validateAndSubmit,
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        minWidth: 120,
                        onPressed: () => {Navigator.pushNamed(context, '/')},
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                showErrorMessage(),
              ],
            ),
          )),
    );

    return Scaffold(body: WaveStack(child: mainContent));
  }
}
