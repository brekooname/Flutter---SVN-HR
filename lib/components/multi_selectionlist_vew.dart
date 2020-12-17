import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';
import 'package:sven_hr/models/response/approval_list.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class MultiSelectionLOVListView extends StatefulWidget {
  List<LovValue> lovs;

  MultiSelectionLOVListView({@required this.lovs});

  @override
  _MultiSelectionLOVListViewState createState() =>
      _MultiSelectionLOVListViewState();
}

class _MultiSelectionLOVListViewState extends State<MultiSelectionLOVListView> {
  List<String> listofSelected = List();

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
              Navigator.of(context, rootNavigator: true).pop('dialog');
            });
          },
        ),
      ],
      content: Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.lovs[index].isSelected = !widget.lovs[index].isSelected;
                setState(() {});
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
                          widget.lovs[index].isSelected =
                              !widget.lovs[index].isSelected;
                          if (widget.lovs[index].isSelected) {
                            listofSelected.add(widget.lovs[index].row_id);
                          } else {
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
  _MultiSelectionTypeListViewState createState() =>
      _MultiSelectionTypeListViewState();
}

class _MultiSelectionTypeListViewState
    extends State<MultiSelectionTypeListView> {
  List<String> listofSelected = List();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
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
        ),
      ],
      content: Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.types[index].isSelected =
                    !widget.types[index].isSelected;
                setState(() {});
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
                          widget.types[index].isSelected =
                              !widget.types[index].isSelected;
                          if (widget.types[index].isSelected) {
                            listofSelected.add(widget.types[index].row_id);
                          } else {
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
  List<String> listofSelected = List();

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
              Navigator.of(context, rootNavigator: true).pop('dialog');
            });
          },
        ),
      ],
      content: Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {});
              },
              child: Container(
                color: AppTheme.kPrimaryColor.withOpacity(0.2),
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

class ApprovalInboxAttachmentsListView extends StatefulWidget {
  List<ApprovalInboxAttachmentsResponse> attachmentsList;

  ApprovalInboxAttachmentsListView({this.attachmentsList});

  @override
  _ApprovalInboxAttachmentsListViewState createState() =>
      _ApprovalInboxAttachmentsListViewState(attachmentsList);
}

class _ApprovalInboxAttachmentsListViewState
    extends State<ApprovalInboxAttachmentsListView> {
  List<ApprovalInboxAttachmentsResponse> attachmentsList;
  bool showSpinner = false;

  _ApprovalInboxAttachmentsListViewState(this.attachmentsList);
  ApprovalInboxController _approvalInboxController;

  void downLoadFile(String attachId, String attachName) async {
    setState(() {
      showSpinner=true;
    });
    _approvalInboxController = ApprovalInboxController();

    await _approvalInboxController
        .downloadFile(attachId, attachName)
        .then((value) {
      setState(() {
        if (value != null && value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          ToastMessage.showSuccessMsg(
              AppTranslations.of(context).text(Const.LOCALE_KEY_DOWNLOAD_FINISHED));
        } else {
          ToastMessage.showErrorMsg(AppTranslations.of(context).text(value));
        }
        print(value);
      });
    });

    setState(() {
      showSpinner=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: AppTheme.kPrimaryColor,
          ),
          tooltip: 'close',
          hoverColor: AppTheme.kPrimaryColor,
          splashColor: AppTheme.kPrimaryColor,
          onPressed: () {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            });
          },
        ),
      ],
      content: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                margin: EdgeInsets.all(5),
                color: AppTheme.kPrimaryColor.withOpacity(0.2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(attachmentsList[index].attachment_name),
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.download_outlined,
                        color: AppTheme.kPrimaryColor,
                      ),
                      tooltip: 'view',
                      hoverColor: AppTheme.kPrimaryColor,
                      splashColor: AppTheme.kPrimaryColor,
                      onPressed: () {
                        downLoadFile(attachmentsList[index].attachment_rowId,
                            attachmentsList[index].attachment_name);
                      },
                    ),

                  ],
                ),
              );
            },
            itemCount: attachmentsList.length,
          ),
        ),
      ),
    );
  }



}
