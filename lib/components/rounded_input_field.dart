import 'package:flutter/material.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType inputType;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.inputType=TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppTheme.kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppTheme.kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,

        ),
        keyboardType: inputType,
      ),
    );
  }
}
