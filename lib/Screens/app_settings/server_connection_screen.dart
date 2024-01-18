import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Login/components/background.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/rounded_button.dart';
import 'package:sven_hr/components/rounded_checkbox_field.dart';
import 'package:sven_hr/components/rounded_input_field.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class ServerConnectionScreen extends StatefulWidget {
  static final id = "ServerConnectionScreen";
  bool? inside;

  ServerConnectionScreen({this.inside = false});

  @override
  _ServerConnectionScreenState createState() =>
      _ServerConnectionScreenState(inside!);
}

class _ServerConnectionScreenState extends State<ServerConnectionScreen> {
  bool? inside;
  bool? showSpinner = false;
  String? _serverIP, _port;
  bool? _isIntegrated = false;
  final _formKey = GlobalKey<FormState>(); // Add this line

  _ServerConnectionScreenState(this.inside);

  void saveServerHost() async {
    if (!_formKey.currentState!.validate()) {
      return; // If form is not valid, do not proceed.
    }
    _formKey.currentState!.save(); // This will call onSaved of each TextFormField

    setState(() {
      showSpinner = true;
    });
    if (_serverIP!.isEmpty) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context)!.text(Const.INVALID_SERVER_IP));
      return;
    }

    if (_port!.isEmpty) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context)!.text(Const.INVALID_SERVER_PORT));
      return;
    }
    String fullUrl = ApiConnections.main_part + _serverIP! + ":" + _port!;
    if (_isIntegrated!) {
      fullUrl += ApiConnections.netsuite_part;
    } else {
      fullUrl += ApiConnections.sven_part;
    }
    // test connection
    NetworkHelper helper = NetworkHelper(url: fullUrl);
    bool isConnected = await helper.testConnection();
    print('isConnected:'+isConnected.toString());
    print('url:'+fullUrl.toString());
    if (!isConnected) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context)!.text(Const.INVALID_SERVER_IP));
      setState(() {
        showSpinner = false;
      });
      return;
    }

    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.clear();

    prefs.setString(Const.SHARED_KEY_SERVER_IP, _serverIP!);
    prefs.setString(Const.SHARED_KEY_SERVER_PORT, _port!);
    prefs.setBool(Const.SHARED_KEY_IS_INTEGRATED, _isIntegrated!);

    prefs.setString(Const.SHARED_KEY_FULL_HOST_URL, fullUrl);
    print('saved ip '+_serverIP.toString());
    print('saved _port '+_port.toString());
    setState(() {
      showSpinner = false;
    });
    Navigator.pop(context);
    navigateWithFade(context, LoginScreen(), 500); // 500 milliseconds for fade
  }

  void navigateWithFade(BuildContext context, Widget destination, int duration) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: duration),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ModernTheme.themeData,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: ModernTheme.backgroundGradient,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Connect to Server',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildTextField('Server IP', Icons.cloud_queue, false),
                    SizedBox(height: 15),
                    _buildTextField('Port', Icons.settings_ethernet, true),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ModernTheme.accentColor),
                        shadowColor: MaterialStateProperty.all(Colors.black45),
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveServerHost();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(String label, IconData icon, bool isNumeric) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: Icon(icon, color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ModernTheme.accentColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: (value) {
        if (isNumeric) {
          _port = value;
        } else {
          _serverIP = value;
        }
      },
    );
  }
}


class ModernTheme {
  static const Color gradientStart = Color(0xC3F5F5F5); // Dark Blue, similar to the XML background
  static const Color gradientEnd = Color(0xFF1b4965); // Slightly lighter shade of blue
  static const Color accentColor = Color(0xFF1b4963); // Complementary lighter blue
  static const Color backgroundColor = Color(0xFF0f2e41); // Dark Blue, same as the XML background for consistency
  static const Color textColor = Color(0xFFFFFFFF); // White for contrast against the dark background

  static final ThemeData themeData = ThemeData(
    primaryColor: gradientStart,
    hintColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: textColor),
      bodyText2: TextStyle(color: textColor),
      // Define other text styles if necessary
    ),
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

