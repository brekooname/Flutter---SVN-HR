import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sven_hr/Screens/Home/home_screen.dart';
import 'package:sven_hr/Screens/Leaves/leave_request_screen.dart';
import 'package:sven_hr/Screens/Leaves/leaves_transaction_screen.dart';
import 'package:sven_hr/Screens/Vacations/picker_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_request_screen.dart';
import 'package:sven_hr/Screens/Vacations/vacation_transaction_screen.dart';
import 'package:sven_hr/Screens/navigation_home_screen.dart';
import 'package:sven_hr/Screens/Login/login_screen.dart';
import 'package:sven_hr/Screens/profile/employee_profile_screen.dart';
import 'package:sven_hr/localization/app_translations_delegate.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'localization/application.dart';

var initialRoute;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //check if user login or not
  String prefTokenId = prefs.get(Const.SHARED_KEY_TOKEN_ID);
  if (prefTokenId != null && !prefTokenId.isEmpty) {
    initialRoute = NavigationHomeScreen.id;
  } else {
    initialRoute = LoginScreen.id;
  }
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  static bool isEN = true;

  // AppTranslationsDelegate _newLocaleDelegate;
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.changeLanguage(newLocale);

    if (newLocale.languageCode.compareTo(Const.LANGUAGE_CODE_EN) == 0) {
      isEN = true;
    } else {
      isEN = false;
    }
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    // newLocaleDelegate = AppTranslationsDelegate(
    //      newLocale: Locale(languagesMap['Arabic']));
    application.onLocaleChanged = onLocaleChange;
  }

  void select(String language) {
    print("dd " + language);
    onLocaleChange(Locale(languagesMap[language]));
    setState(() {});
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SVEN HR',
      theme: ThemeData(
        primaryColor: AppTheme.kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: initialRoute,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        NavigationHomeScreen.id: (context) => NavigationHomeScreen(),
        ProfilePage.id: (context) => ProfilePage(),
        VacationsTransaction.id: (context) => VacationsTransaction(),
        PickerScreen.id: (context) => PickerScreen(),
        LeavesTransaction.id: (context) => LeavesTransaction(),
        VacationRequestScreen.id: (context) => VacationRequestScreen(),
        LeaveRequestScreen.id: (context) => LeaveRequestScreen(),
      },
      localizationsDelegates: [
        newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("ar", ""),
      ],
      locale: _locale,
    );
  }
}

AppTranslationsDelegate newLocaleDelegate =
    AppTranslationsDelegate(newLocale: null);
final List<String> languagesList = application.supportedLanguages;
final List<String> languageCodesList = application.supportedLanguagesCodes;

final Map<dynamic, dynamic> languagesMap = {
  languagesList[0]: languageCodesList[0],
  languagesList[1]: languageCodesList[1],
};
