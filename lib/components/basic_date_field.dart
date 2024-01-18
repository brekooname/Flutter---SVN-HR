 import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class BasicDateField extends StatelessWidget {
  final format = DateFormat(Const.DATE_FORMAT);
  final String? title;

  BasicDateField({this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            Text(title!,style: AppTheme.subtitle ),
            Padding(
              padding: const EdgeInsets.only(top:5 ,right: 10),
              child: DateTimeField(
                textAlign: TextAlign.center,
                style: AppTheme.subtitle,
                format: format,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}