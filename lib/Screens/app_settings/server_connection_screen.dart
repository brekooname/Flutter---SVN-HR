import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Login/components/background.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/components/rounded_button.dart';
import 'package:sven_hr/components/rounded_checkbox_field.dart';
import 'package:sven_hr/components/rounded_input_field.dart';
import 'package:sven_hr/components/rounded_password_field.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/services/networking.dart';
import 'package:sven_hr/utilities/api_connectons.dart';
import 'package:sven_hr/utilities/constants.dart';

class ServerConnectionScreen extends StatefulWidget {
  static final id = "ServerConnectionScreen";
  bool inside;

  ServerConnectionScreen({this.inside});

  @override
  _ServerConnectionScreenState createState() =>
      _ServerConnectionScreenState(inside);
}

class _ServerConnectionScreenState extends State<ServerConnectionScreen> {
  bool inside;
  bool showSpinner = false;
  String _serverIP, _port;
  bool _isIntegrated = false;

  _ServerConnectionScreenState(this.inside) {
    if (inside == null) {
      inside = false;
    }
  }

  void saveServerHost() async {
    setState(() {
      showSpinner = true;
    });
    if (_serverIP == null || _serverIP.isEmpty) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context).text(Const.INVALID_SERVER_IP));
      return;
    }

    if (_port == null || _port.isEmpty) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context).text(Const.INVALID_SERVER_PORT));
      return;
    }
    String full_url = ApiConnections.main_part + _serverIP + ":" + _port;
    if (_isIntegrated) {
      full_url += ApiConnections.netsuite_part;
    } else {
      full_url += ApiConnections.sven_part;
    }
    // test connection
    NetworkHelper helper = NetworkHelper(url: full_url);
    bool isConnected = await helper.testConnection();
    print('isConnected:'+isConnected.toString());
    print('url:'+full_url.toString());
    if (!isConnected) {
      ToastMessage.showErrorMsg(
          AppTranslations.of(context).text(Const.INVALID_SERVER_IP));
      setState(() {
        showSpinner = false;
      });
      return;
    }

    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.clear();

    prefs.setString(Const.SHARED_KEY_SERVER_IP, _serverIP);
    prefs.setString(Const.SHARED_KEY_SERVER_PORT, _port);
    prefs.setBool(Const.SHARED_KEY_IS_INTEGRATED, _isIntegrated);

    prefs.setString(Const.SHARED_KEY_FULL_HOST_URL, full_url);

    setState(() {
      showSpinner = false;
    });
    Navigator.pop(context);
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget screen_body() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedInputField(
            icon: Icons.miscellaneous_services,
            hintText:
            AppTranslations.of(context).text(Const.LOCALE_KEY_SERVER_IP),
            inputType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              _serverIP = value;
            },
          ),
          RoundedInputField(
            icon: Icons.point_of_sale,
            hintText:
            AppTranslations.of(context).text(Const.LOCALE_KEY_SERVER_PORT),
            inputType: TextInputType.number,
            onChanged: (value) {
              _port = value;
            },
          ),
          RoundedCheckBoxField(
            value: _isIntegrated,
            hintText: AppTranslations.of(context).text(
              Const.LOCALE_KEY_IS_INTEGRATED,
            ),
            onChanged: (value) {
              setState(
                    () {
                  _isIntegrated = value;
                },
              );
            },
          ),
          RoundedButton(
            text: AppTranslations.of(context).text(Const.LOCALE_KEY_SAVE),
            press: () async {
              saveServerHost();
            },
          ),
          SizedBox(height: size.height * 0.03),
        ],
      );
    }

    if (inside) {
      return ScreenLoader(
        screenName: AppTranslations.of(context)
            .text(Const.LOCALE_KEY_SERVER_CONNECTION),
        screenWidget: ModalProgressHUD(
            inAsyncCall: showSpinner, child: Center(child: screen_body())),
      );
    } else {
      return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Background(
              child: SingleChildScrollView(
                child: screen_body(),
              ),
            ),
          ));
    }
  }
}
