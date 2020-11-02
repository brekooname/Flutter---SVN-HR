import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/models/response/employee_vacation_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class SingleSelectionListView extends StatefulWidget {
  List<EmployeeVacationResponse> employeeVacations;

  SingleSelectionListView({@required this.employeeVacations});

  @override
  _SingleSelectionListViewState createState() =>
      _SingleSelectionListViewState();
}

class _SingleSelectionListViewState extends State<SingleSelectionListView> {
  EmployeeVacationResponse selectedValue;

  @override
  void initState() {
    super.initState();
    if(widget.employeeVacations!=null&& !widget.employeeVacations.isEmpty)
    selectedValue = widget.employeeVacations.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.send,
            color: AppTheme.kPrimaryColor,
          ),
          tooltip: 'select',
          hoverColor: AppTheme.kPrimaryColor,
          splashColor: AppTheme.kPrimaryColor,
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop(selectedValue);
              // Navigator.of(context, selectedValue).pop();
            });
          },
        ),
      ],
      content: Container(
        color: AppTheme.white,
        height: 350,
        width: 300.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                selectedValue = widget.employeeVacations[index];
                setState(() {});
              },
              child: Container(
                color: selectedValue == widget.employeeVacations[index]
                    ? AppTheme.kPrimaryColor.withOpacity(0.1)
                    : null,
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: widget.employeeVacations[index],
                      groupValue: selectedValue,
                      onChanged: (s) {
                        selectedValue = s;
                        setState(() {});
                      },
                      activeColor: AppTheme.kPrimaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.employeeVacations[index].vacation_type_name,
                            style: AppTheme.subtitle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Remaining Balance ',
                                style: AppTheme.caption,
                              ),
                              Text(
                                widget
                                    .employeeVacations[index].remaining_balance
                                    .toString(),
                                style: AppTheme.subtitle,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Due Balance ',
                                style: AppTheme.caption,
                              ),
                              Text(
                                widget.employeeVacations[index].due_balance.toStringAsFixed(2)
                                    .toString(),
                                style: AppTheme.subtitle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: widget.employeeVacations.length,
        ),
      ),
    );
  }
}
