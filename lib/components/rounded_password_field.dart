import 'package:flutter/material.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          hintText: AppTranslations.of(context)
              .text(Const.LOCALE_KEY_PASSWORD),
          icon: Icon(
            Icons.lock,
            color: AppTheme.kPrimaryColor,
          ),
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
