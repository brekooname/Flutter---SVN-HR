import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

import 'custom_drawer/menue_top_bar.dart';

class ScreenLoader extends StatefulWidget {
  String screenName;
  Widget screenWidget;

  ScreenLoader({this.screenName, this.screenWidget});

  @override
  _ScreenLoaderState createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends State<ScreenLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
    );
  }
}
