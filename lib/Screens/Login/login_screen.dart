import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/components/rounded_button.dart';
import 'package:sven_hr/components/rounded_input_field.dart';
import 'package:sven_hr/components/rounded_password_field.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'components/background.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  static final id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "mansour";
  String _password = "123123";
  // String _username;
  // String _password;

  LoginController loginController = LoginController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginImage(size: size),

              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: AppTranslations.of(context)
                    .text(Const.LOCALE_KEY_USERNAME),
                onChanged: (value) {
                  _username = value;
                },
              ),
              RoundedPasswordField(
                text: AppTranslations.of(context)
                    .text(Const.LOCALE_KEY_PASSWORD),
                onChanged: (value) {
                  _password = value;
                },
              ),
              RoundedButton(
                text: AppTranslations.of(context)
                    .text(Const.LOCALE_KEY_LOGIN),
                press: () async {
                  setState(() {
                    showSpinner = true;
                    print('Spinner status ' + showSpinner.toString());
                  });

                  var s = await loginController.loginVerifications(
                      context, _username, _password);
                  if (s != null) {}

                  setState(() {
                    showSpinner = false;
                    print('Spinner status ' + showSpinner.toString());
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    ));
  }
}

class LoginImage extends StatelessWidget {
  final Size size;
  String loginImage = "";

  LoginImage({this.size}) {
    if (Platform.isIOS) {
      loginImage = "assets/images/netsuiteLogo.png";
    } else if (Platform.isAndroid) {
      loginImage = "assets/images/netsuiteLogo.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      loginImage,
      height: size.height*0.1,
    );
  }
}
