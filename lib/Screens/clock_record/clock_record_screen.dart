import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart'
    show Connectivity, ConnectivityResult;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_mac/get_mac.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/clock_record/clock_record_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/last_check_response.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';
import 'dart:async';

class ClockRecordScreen extends StatefulWidget {
  static String id = "ClockRecordScreen";
  @override
  _ClockRecordScreenState createState() => _ClockRecordScreenState();
}

class _ClockRecordScreenState extends State<ClockRecordScreen> {
  bool showSpinner = false;
  bool buttonClosedIsPressed = false;
  bool buttonSendIsPressed = false;
  LastCheckResponse _lastCheck;
  ClockRecordController _clockRecordController;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  // final WifiInfo _wifiInfo = WifiInfo();
  String wifiBSSID = "";
  String recType='';
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _clockRecordController = ClockRecordController();
    getLastCheck();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _gpsService();
    super.initState();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        try {
          wifiBSSID = await _connectivity.getWifiBSSID();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi BSSID: $wifiBSSID\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  void getLastCheck() async {
    _lastCheck = LastCheckResponse();
    await _clockRecordController.getLastCheck().then((value) {
      setState(() {
        if (value != null) {
          if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
            _lastCheck = _clockRecordController.lastCheck;
            getRecType();
          }
        }
      });
    });
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        // _gpsService(context);
                      })
                ],
              );
            });
      }
    }
  }

/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  void userVerification(String clockType) async {
    buttonSendIsPressed = true;
    showSpinner = true;

    await _clockRecordController
        .userVerification(networkBSSID: wifiBSSID, clockType: clockType)
        .then((value) {
      if (value == null) {
        ToastMessage.showErrorMsg(Const.REQUEST_FAILED);
      } else if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
        ToastMessage.showSuccessMsg(Const.SYSTEM_SUCCESS_MSG);
        Navigator.pop(context);
      } else {
        ToastMessage.showErrorMsg(value);
      }
      buttonSendIsPressed = false;
      showSpinner = false;
      setState(() {});
    });
  }

  Future<void> getRecType()async{
     LovValue lovValue=LovValue();
     lovValue= await  lovValue.getLovsByRowId(_lastCheck.rec_type );
     if(lovValue.row_id!=null){
       recType =lovValue.display;
     }
     setState(() {

     });
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        color: AppTheme.nearlyWhite,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_CLOCK_RECORD),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: AppTheme.kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Expanded(
                      flex: 3,
                      child: Card(
                        color: AppTheme.kPrimaryLightColor,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.kPrimaryLightColor.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(AppTranslations.of(context).text(Const.LOCALE_KEY_lAST_CHECK_IN_OUT),
                                  style: TextStyle(
                                      color: AppTheme.kPrimaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),

                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REC_DATE)),
                                    subtitle: Text(
                                        _lastCheck.rec_date != null
                                            ? _lastCheck.rec_date
                                            : "-"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_REC_TIME)),
                                    subtitle: Text(
                                        _lastCheck.rec_time != null
                                            ? ApplicationController.formatToHours(_lastCheck.rec_time).toString()
                                            : "-"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_TYPE)),
                                    subtitle: Text(
                                        recType),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          userVerification(Const.RECORD_TYPE_IN);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: buttonSendIsPressed
                                ? AppTheme.nearlyWhite.withOpacity(0.1)
                                : AppTheme.red,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.red.withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.fingerprint,
                                    color: AppTheme.white,
                                  )),
                                  TextSpan(
                                    text: AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_CHECK_IN),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                                ]),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          userVerification(Const.RECORD_TYPE_OUT);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: buttonSendIsPressed
                                ? AppTheme.nearlyWhite.withOpacity(0.1)
                                : AppTheme.green,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.green.withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.fingerprint,
                                    color: AppTheme.white,
                                  )),
                                  TextSpan(
                                    text: AppTranslations.of(context)
                                        .text(Const.LOCALE_KEY_CHECK_OUT),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      color: AppTheme.nearlyWhite,
                                    ),
                                  ),
                                ]),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: buttonSendIsPressed
                                ? AppTheme.nearlyWhite.withOpacity(0.1)
                                : AppTheme.nearlyBlue,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.nearlyBlue.withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 19),
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.cancel_outlined,
                                  color: AppTheme.white,
                                )),
                                TextSpan(
                                  text: AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_CANCEL),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
