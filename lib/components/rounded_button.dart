import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color = AppTheme.kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton( // Use ElevatedButton instead of FlatButton
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            primary: color,
          ),
          onPressed: press,
          child: Text(
            text!,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
