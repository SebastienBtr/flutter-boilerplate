import 'package:flutter_boilerplate/screens/password_forgot/passwordForgotPage.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter_boilerplate/widgets/formTextField.dart';
import 'package:flutter/material.dart';

// Simple login form with email and password
class LoginForm extends StatefulWidget {
  const LoginForm({this.onSubmit});

  // Calback function when we submit the form
  // This function has two arguments: the email and the password
  final dynamic onSubmit;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // key of the form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // The email controller
  final TextEditingController emailCtrl = TextEditingController();
  // The password controller
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormTextField(
            label: Translations.of(context).text('Email address'),
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
          ),
          FormTextField(
            label: Translations.of(context).text('Password'),
            controller: passwordCtrl,
            obscureText: true,
            isRequired: true,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                child: Text(
                  Translations.of(context).text('password forgot'),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => PasswordForgotPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text(
                Translations.of(context).text('Login').toUpperCase(),
              ),
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  widget.onSubmit(
                      emailCtrl.text.toLowerCase(), passwordCtrl.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
