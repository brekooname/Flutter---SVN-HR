import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedOutLineButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData icon;

  RoundedOutLineButton(
      {@required this.title, @required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      textColor: AppTheme.kPrimaryColor,
      color: AppTheme.white,
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(title),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            color: AppTheme.kPrimaryColor,
          )),
    );
  }
}


// return RaisedButton.icon(
// textColor: AppTheme.kPrimaryColor,
// color: AppTheme.white,
// onPressed: onPressed,
// icon: Icon(icon, size: 18),
// label: Text(title),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(18.0),
// side: BorderSide(
// color: AppTheme.kPrimaryColor,
// )),
// );