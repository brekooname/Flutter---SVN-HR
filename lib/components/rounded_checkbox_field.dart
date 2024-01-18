import 'package:flutter/material.dart';
import 'package:sven_hr/components/text_field_container.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedCheckBoxField extends StatelessWidget {
  final String? hintText;
  final bool? value;
  final void Function(bool?)? onChanged;

  const RoundedCheckBoxField({
    Key? key,
    this.hintText,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Row(
        children: [
          Icon(Icons.integration_instructions,color: AppTheme.kPrimaryColor,),
          Text(hintText!,style: TextStyle(color: AppTheme.grey),),
          Checkbox(
            value: value,
            activeColor: AppTheme.kPrimaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

