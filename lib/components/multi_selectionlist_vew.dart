import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/utilities/app_theme.dart';

class MultiSelectionLOVListView extends StatefulWidget {
  List<LovValue> lovs;

  MultiSelectionLOVListView({@required this.lovs});

  @override
  _MultiSelectionLOVListViewState createState() => _MultiSelectionLOVListViewState();
}

class _MultiSelectionLOVListViewState extends State<MultiSelectionLOVListView> {
  List<String> listofSelected =List();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[   IconButton(
        icon: Icon(
          Icons.send,
          color: AppTheme.kPrimaryColor,
        ),
        tooltip: 'select',
        hoverColor: AppTheme.kPrimaryColor,
        splashColor: AppTheme.kPrimaryColor,
        onPressed: () {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        },
      ),],
      content:  Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.lovs[index].isSelected = !widget.lovs[index].isSelected;
                setState(() {
                });
              },
              child: Container(
                color: widget.lovs[index].isSelected
                    ? AppTheme.kPrimaryColor.withOpacity(0.2)
                    : null,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: widget.lovs[index].isSelected,
                        onChanged: (s) {
                          widget.lovs[index].isSelected = !widget.lovs[index].isSelected;
                          if(widget.lovs[index].isSelected){
                            listofSelected.add(widget.lovs[index].row_id);
                          }else{
                            listofSelected.remove(widget.lovs[index].row_id);
                          }
                          setState(() {
                            print(listofSelected);
                          });
                        }),
                    Text(widget.lovs[index].display)
                  ],
                ),
              ),
            );
          },
          itemCount: widget.lovs.length,
        ),
      ),
    );
  }
}

class MultiSelectionTypeListView extends StatefulWidget {
  List<VacationType> types;


  MultiSelectionTypeListView({@required this.types});

  @override
  _MultiSelectionTypeListViewState createState() => _MultiSelectionTypeListViewState();
}

class _MultiSelectionTypeListViewState extends State<MultiSelectionTypeListView> {
  List<String> listofSelected =List();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[   IconButton(
        icon: Icon(
          Icons.send,
          color: AppTheme.kPrimaryColor,
        ),
        tooltip: 'search',
        hoverColor: AppTheme.kPrimaryColor,
        splashColor: AppTheme.kPrimaryColor,
        onPressed: () {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        },
      ),],
      content:  Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.types[index].isSelected = !widget.types[index].isSelected;
                setState(() {
                });
              },
              child: Container(
                color: widget.types[index].isSelected
                    ? AppTheme.kPrimaryColor.withOpacity(0.2)
                    : null,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: widget.types[index].isSelected,
                        onChanged: (s) {
                          widget.types[index].isSelected = !widget.types[index].isSelected;
                          if(widget.types[index].isSelected){
                            listofSelected.add(widget.types[index].row_id);
                          }else{
                            listofSelected.remove(widget.types[index].row_id);
                          }
                          setState(() {
                            print(listofSelected);
                          });
                        }),
                    Text(widget.types[index].name)
                  ],
                ),
              ),
            );
          },
          itemCount: widget.types.length,
        ),
      ),
    );
  }
}

class AttachmentsListView extends StatefulWidget {
  List<String> paths;

  AttachmentsListView({@required this.paths});

  @override
  _AttachmentsListViewState createState() => _AttachmentsListViewState();
}

class _AttachmentsListViewState extends State<AttachmentsListView> {
  List<String> listofSelected =List();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[   IconButton(
        icon: Icon(
          Icons.send,
          color: AppTheme.kPrimaryColor,
        ),
        tooltip: 'select',
        hoverColor: AppTheme.kPrimaryColor,
        splashColor: AppTheme.kPrimaryColor,
        onPressed: () {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        },
      ),],
      content:  Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {

                setState(() {
                });
              },
              child: Container(
                color:AppTheme.kPrimaryColor.withOpacity(0.2),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: AppTheme.kPrimaryColor,
                      ),
                      tooltip: 'select',
                      hoverColor: AppTheme.kPrimaryColor,
                      splashColor: AppTheme.kPrimaryColor,
                      onPressed: () {
                        setState(() {
                          widget.paths.removeAt(index);
                        });
                      },
                    ),
                    Flexible(child: Text(widget.paths[index].split('/').last))
                  ],
                ),
              ),
            );
          },
          itemCount: widget.paths.length,
        ),
      ),
    );
  }
}