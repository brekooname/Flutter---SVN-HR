import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/services/location.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class AppSettingsScreen extends StatefulWidget {
  static String id = "AppSettingsScreen";
  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen>
    with SingleTickerProviderStateMixin {
  double latitude;
  double longitude;
  String wifiName;
  String wifiBSSID;
  String WifiIP;
  bool buttonSendIsPressed = false;
  String locationName;
  String locationRange;
  AnimationController _controller;
  Animation _animation;
  FocusNode _focusNode = FocusNode();

  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  String _connectionStatus = 'Unknown';

/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
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

  void getCurrentLocation() async {
    Location currentLocation = Location();
    currentLocation.getCurrentLocation().then((value) => {
          setState(() {
            latitude = currentLocation.latitude;
            longitude = currentLocation.longitude;
          })
        });
  }

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _gpsService();
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
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

        try {
          wifiName = await _connectivity.getWifiName();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          WifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          WifiIP = "Failed to get Wifi IP";
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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName:
          AppTranslations.of(context).text(Const.LOCALE_KEY_APP_SETTING),
      screenWidget: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.kPrimaryLightColor.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_LOCATION),
                        style: TextStyle(
                            color: AppTheme.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Text(AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LATITUDE)),
                              subtitle: Text(
                                  latitude != null ? latitude.toString() : "-"),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Text(AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LONGITUDE)),
                              subtitle: Text(longitude != null
                                  ? longitude.toString()
                                  : "-"),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: AppTheme.kPrimaryColor,
                              ),
                              onPressed: () async {
                                await getCurrentLocation();
                              }),
                        ],
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFieldContainer(
                          child: TextField(
                            cursorColor: AppTheme.kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LOCATION_NAME),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: AppTheme.kPrimaryColor,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                locationName = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFieldContainer(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            cursorColor: AppTheme.kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: AppTranslations.of(context)
                                  .text(Const.LOCALE_KEY_LOCATION_RANGE),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.format_list_numbered,
                                  color: AppTheme.kPrimaryColor,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                locationName = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: buttonSendIsPressed
                                    ? AppTheme.nearlyWhite.withOpacity(0.1)
                                    : AppTheme.nearlyBlue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          AppTheme.nearlyBlue.withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_ADD_LOCATION),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.kPrimaryLightColor.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppTranslations.of(context)
                            .text(Const.LOCALE_KEY_WIFI_INFORMATION),
                        style: TextStyle(
                            color: AppTheme.kPrimaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      // Flexible(
                      //   flex: 1,
                      //   child: ListTile(
                      //     title: Text(AppTranslations.of(context)
                      //         .text(Const.LOCALE_KEY_STATUS)),
                      //     subtitle: Text(_connectionStatus != null
                      //         ? _connectionStatus.toString()
                      //         : "-"),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_WIFI_NAME)),
                          subtitle: Text(
                              wifiName != null ? wifiName.toString() : "-"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_WIFI_BSSID)),
                          subtitle: Text(
                              wifiBSSID != null ? wifiBSSID.toString() : "-"),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: Text(AppTranslations.of(context)
                              .text(Const.LOCALE_KEY_WIFI_IP)),
                          subtitle:
                              Text(WifiIP != null ? WifiIP.toString() : "-"),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: buttonSendIsPressed
                                    ? AppTheme.nearlyWhite.withOpacity(0.1)
                                    : AppTheme.nearlyBlue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          AppTheme.nearlyBlue.withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  AppTranslations.of(context)
                                      .text(Const.LOCALE_KEY_ADD_NETWORK),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: AppTheme.nearlyWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
