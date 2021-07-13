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
    this.icon = Icons.person_outline_outlined,
    this.onChanged,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.blue,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
