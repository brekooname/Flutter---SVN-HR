import 'package:flutter/material.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class RoundedDropMenue extends StatefulWidget {
  final String? dropdownValue;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? dropdownMenuItems;
  final String? hedaerLabel;

  RoundedDropMenue(
      {this.dropdownValue, this.onChanged, this.dropdownMenuItems,this.hedaerLabel});

  @override
  _RoundedDropMenueState createState() => _RoundedDropMenueState();
}

class _RoundedDropMenueState extends State<RoundedDropMenue> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(0),
            margin:EdgeInsets.all(0) ,
            // decoration: ShapeDecoration(
            //   color: AppTheme.white,
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         width: 1.0,
            //         style: BorderStyle.solid,
            //         color: AppTheme.kPrimaryColor),
            //     borderRadius: BorderRadius.all(Radius.circular(18.0)),
            //   ),
            // ),
            child: DropdownButton(
              style: TextStyle(color: AppTheme.kPrimaryColor),
              icon: Icon(Icons.star, color: AppTheme.kPrimaryColor ,size: 15,),
              value: widget.dropdownValue,
              items: widget.dropdownMenuItems,
              onChanged: widget.onChanged,
            )),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: Container(
        //     decoration: ShapeDecoration(
        //       color: AppTheme.white,
        //       shape: RoundedRectangleBorder(
        //         side: BorderSide(
        //             color: AppTheme.white),
        //         borderRadius: BorderRadius.all(Radius.circular(18.0)),
        //       ),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(2.0),
        //       child: Text(
        //         widget.hedaerLabel,
        //         style: TextStyle(color: AppTheme.kPrimaryColor.withOpacity(0.3)) ,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
