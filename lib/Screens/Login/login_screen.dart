import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/navigation_home_screen.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/constants.dart';
import '../../components/rounded_button.dart';
import '../../components/text_field_container.dart';
import '../app_settings/server_connection_screen.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  static final id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _username;
  String? _password;
  LoginController loginController = LoginController();
  bool showSpinner = false;
  bool _passwordVisible = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ModernTheme.backgroundGradient,
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginImage(size: size),
                  SizedBox(height: size.height * 0.03),
                  _buildInputField(Icons.person_outline, "Username", false),
                  _buildInputField(Icons.lock_outline, "Password", true),
                  _buildLoginButton(context),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildInputField(IconData icon, String hintText, bool isPassword) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isPassword && !_passwordVisible,
        onChanged: isPassword ? (value) => _password = value : (value) => _username = value,
        cursorColor: Colors.blueGrey,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.blueGrey),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.blueGrey),
          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ModernTheme.accentColor)),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )
              : null,
        ),
        style: TextStyle(color: Colors.blueGrey),
      ),
    );
  }
  Widget _buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.all(0),
        ),
        onPressed: () async {
          login();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            constraints: BoxConstraints.expand(),
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (_username == null || _password == null) {
      ToastMessage.showErrorMsg("Username and password cannot be empty");
      return;
    }

    setState(() {
      showSpinner = true;
    });

    await loginController
        .loginVerifications(_username!, _password!)
        .then((value) {
      if (value != null) {
        if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          Navigator.pop(context);
          Navigator.pushNamed(context, NavigationHomeScreen.id);
          ToastMessage.showSuccessMsg(value.toString());
        } else {
          ToastMessage.showErrorMsg(value.toString());
        }
      }
      setState(() {
        showSpinner = false;
      });
    });
  }
}

class LoginImage extends StatelessWidget {
  final Size? size;

  LoginImage({this.size});

  @override
  Widget build(BuildContext context) {
    String loginImage = "assets/images/netsuiteLogo.png"; // Assuming a common image for all platforms
    return Image.asset(loginImage, height: size!.height * 0.1);
  }
}
