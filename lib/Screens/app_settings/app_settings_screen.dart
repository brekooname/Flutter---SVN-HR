import 'dart:async';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:android_intent/android_intent.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sven_hr/Screens/app_settings/app_settings_controller.dart';
import 'package:sven_hr/Screens/app_settings/server_connection_screen.dart';
import 'package:sven_hr/Screens/screen_loader.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
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
  double? latitude;
  double? longitude;
  String? wifiName;
  String? wifiBSSID;
  String? wifiIP;
  bool buttonSendIsPressed = false;
  String? locationName;
  num? locationRange;
  AnimationController? _controller;
  Animation? _animation;
  FocusNode _focusNode = FocusNode();
  APPSettingsController? _appSettingsController;

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  String _connectionStatus = 'Unknown';

/*Check if gps service is enabled or not*/
  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  ElevatedButton(
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
    _appSettingsController = APPSettingsController();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _gpsService();
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
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

    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        try {
          var wifiBSSID = await (NetworkInfo().getWifiBSSID());
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          var wifiName = await (NetworkInfo().getWifiName());
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          var wifiIP = await (NetworkInfo().getWifiIP());
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
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

  void addNewLocation() async {
    buttonSendIsPressed = true;
    await _appSettingsController!
        .addNewLocation(
            latitude: latitude.toString(),
            longitude: longitude.toString(),
            locationRange: locationRange,
            locationName: locationName)
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      ToastMessage.showSuccessMsg(Const.REQUEST_SENT_SUCCESSFULLY);
      // Navigator.pop(context);
    } else {
      ToastMessage.showErrorMsg(value);
    }
      buttonSendIsPressed = false;
      setState(() {});
    });
  }

  void addNewNetwork() async {
    buttonSendIsPressed = true;
    await _appSettingsController!
        .addNewNetwork(
      wifiBSSID: wifiBSSID,
      wifiName: wifiName,
      wifiIP: wifiIP,
    )
        .then((value) {
      if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
      ToastMessage.showSuccessMsg(Const.REQUEST_SENT_SUCCESSFULLY);
      // Navigator.pop(context);
    } else {
      ToastMessage.showErrorMsg(value);
    }
      buttonSendIsPressed = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      screenName: AppTranslations.of(context)!.text(Const.LOCALE_KEY_APP_SETTING),
      screenWidget: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSettingsSection(
                  context: context,
                  titleKey: Const.LOCALE_KEY_LOCATION,
                  content: _buildLocationContent(context),
                ),
                SizedBox(height: 5),
                _buildSettingsSection(
                  context: context,
                  titleKey: Const.LOCALE_KEY_WIFI_INFORMATION,
                  content: _buildWifiContent(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSettingsSection({BuildContext? context, String? titleKey, Widget? content}) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                AppTranslations.of(context!)!.text(titleKey!),
                style: TextStyle(
                  color: ModernTheme.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              content!,
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildLocationContent(BuildContext context) {
    // This method builds the content for the Location Settings section
    return Column(
      children: [
        // Latitude and Longitude Display
        Row(
          children: [
            Flexible(
              flex: 1,
              child: ListTile(
                title: Text(AppTranslations.of(context)!.text(Const.LOCALE_KEY_LATITUDE),
                style: TextStyle(color: ModernTheme.textColor)),
                subtitle: Text(latitude != null ? latitude.toString() : "-",style: TextStyle(color: ModernTheme.textColor)),
              ),
            ),
            Flexible(
              flex: 1,
              child: ListTile(
                title: Text(AppTranslations.of(context)!.text(Const.LOCALE_KEY_LONGITUDE),style: TextStyle(color: ModernTheme.textColor)),
                subtitle: Text(longitude != null ? longitude.toString() : "-",style: TextStyle(color: ModernTheme.textColor)),
              ),
            ),
            IconButton(
              icon: Icon(Icons.location_on_outlined, color: ModernTheme.textColor),
              onPressed: () async {
                getCurrentLocation();
              },
            ),
          ],
        ),

        // Location Name Input
        TextFieldContainer(
          child: TextFormField(
            validator: (value) => locationName == null
                ? AppTranslations.of(context)!.text(Const.LOCALE_KEY_REQUIRED)
                : null,
            cursorColor: AppTheme.kPrimaryColor,
            decoration: InputDecoration(
              hintText: AppTranslations.of(context)!.text(Const.LOCALE_KEY_LOCATION_NAME),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: ModernTheme.accentColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                locationName = value;
              });
            },
          ),
        ),

        // Add Location Button
        _buildButton(context, Const.LOCALE_KEY_ADD_LOCATION, addNewLocation),
      ],
    );
  }

  Widget _buildWifiContent(BuildContext context) {
    // This method builds the content for the WiFi Information section
    return Column(
      children: [
        // WiFi Name
        ListTile(
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_WIFI_NAME),
            style: TextStyle(color: ModernTheme.textColor),
          ),
          subtitle: Text(
            wifiName != null ? wifiName.toString() : "-",
            style: TextStyle(color: ModernTheme.textColor),
          ),
        ),

        // WiFi BSSID
        ListTile(
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_WIFI_BSSID),
            style: TextStyle(color: ModernTheme.textColor),
          ),
          subtitle: Text(
            wifiBSSID != null ? wifiBSSID.toString() : "-",
            style: TextStyle(color: ModernTheme.textColor),
          ),
        ),

        // WiFi IP
        ListTile(
          title: Text(
            AppTranslations.of(context)!.text(Const.LOCALE_KEY_WIFI_IP),
            style: TextStyle(color: ModernTheme.textColor),
          ),
          subtitle: Text(
            wifiIP != null ? wifiIP.toString() : "-",
            style: TextStyle(color: ModernTheme.textColor),
          ),
        ),

        // Add Network Button
        _buildButton(context, Const.LOCALE_KEY_ADD_NETWORK, addNewNetwork),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String textKey, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            onPressed();
          }
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: ModernTheme.accentColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppTheme.nearlyBlue.withOpacity(0.5),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              AppTranslations.of(context)!.text(textKey),
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
    );
  }
}
