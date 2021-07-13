import 'package:flutter/material.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final textController;
  final String text;
  const RoundedPasswordField(
      {Key key, this.onChanged, this.textController, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textController,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.black),
          icon: Icon(Icons.lock_outline, color: Colors.blue),
//          suffixIcon: Icon(
//            Icons.visibility,
//            color: AppTheme.kPrimaryColor,
//          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
