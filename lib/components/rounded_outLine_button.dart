import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedOutLineButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final IconData? icon;

  RoundedOutLineButton({
    @required this.title,
    @required this.onPressed,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.white,
        onPrimary: AppTheme.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            color: AppTheme.kPrimaryColor,
          ),
        ),
      ),
      onPressed: onPressed as void Function()?, // Ensure onPressed is of the correct type
      icon: Icon(icon, size: 18),
      label: Text(title!),
    );
  }
}
