import 'package:flutter_boilerplate/blocs/mainBloc.dart';
import 'package:flutter_boilerplate/blocs/settingBloc.dart';
import 'package:flutter_boilerplate/services/authService.dart';
import 'package:flutter_boilerplate/translations.dart';
import 'package:flutter/material.dart';

class PasswordForgotBloc extends SettingBloc {
  bool isLoading = false;
  String errorMessage = '';

  // request a reset password link for the given email
  Future<void> requestPassword(
      BuildContext context, dynamic state, String email) async {
    isLoading = true;
    errorMessage = '';
    rebuildWidgets(states: <State>[state]);

    // TODO: uncomment this line to use real api call
    // final bool isSend = await AuthService.instance.requestResetPassword(email);
    const bool isSend = true;

    if (isSend) {
      mainBloc.showToast(
          'Reset password email send. Please check your email inbox.', 5000);
      isLoading = false;
      rebuildWidgets(states: <State>[state]);
    } else {
      errorMessage = Translations.of(context)
          .text('We could not find this email address linked to any account');
      isLoading = false;
      rebuildWidgets(states: <State>[state]);
    }
  }
}

PasswordForgotBloc passwordForgotBloc;
