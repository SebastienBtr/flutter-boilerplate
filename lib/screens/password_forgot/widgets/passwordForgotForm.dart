import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter_boilerplate/widgets/formTextField.dart';
import 'package:flutter/material.dart';

// Form for password recovery
class PasswordForgotForm extends StatefulWidget {
  const PasswordForgotForm({this.onSubmit});

  // Calback function when we submit the form
  // This function has one argument: the email
  final dynamic onSubmit;

  @override
  _PasswordForgotFormState createState() => _PasswordForgotFormState();
}

class _PasswordForgotFormState extends State<PasswordForgotForm> {
  // key of the form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // The email controller
  final TextEditingController emailCtrl = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15),
            child: Text(
              Translations.of(context)
                  .text('Please enter the email address for the account '
                      'you forgot your password to'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 20),
            child: RaisedButton(
              child: Text(
                Translations.of(context)
                    .text('Request new password')
                    .toUpperCase(),
              ),
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  widget.onSubmit(emailCtrl.text.toLowerCase());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
