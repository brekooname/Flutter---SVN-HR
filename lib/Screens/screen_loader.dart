import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/utilities/app_controller.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

import 'custom_drawer/menue_top_bar.dart';

class ScreenLoader extends StatefulWidget {
  String screenName;
  Widget screenWidget;

  ScreenLoader({this.screenName, this.screenWidget});

  @override
  _ScreenLoaderState createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends State<ScreenLoader> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(AppTranslations.of(context).text(Const.LOCALE_KEY_ARE_YOU_SURE)),
        content: new Text(AppTranslations.of(context).text(Const.LOCALE_KEY_DO_YOU_WANT)),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(AppTranslations.of(context).text(Const.LOCALE_KEY_NO)),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text(AppTranslations.of(context).text(Const.LOCALE_KEY_YES)),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Directionality(
        textDirection: MyApp.isEN ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
//          resizeToAvoidBottomPadding: false,
          backgroundColor: AppTheme.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MenueTopBar(
              screenName: this.widget.screenName,
            ),
            Expanded(
              child: this.widget.screenWidget,
            ),
          ],
        ),
        ),
        ),
      ),
    );
  }
}
