import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sven_hr/Screens/app_settings/server_connection_screen.dart';
import 'package:sven_hr/Screens/approval_inbox/approval_inbox_controller.dart';
import 'package:sven_hr/components/flutter_toast_message.dart';
import 'package:sven_hr/dao/lov_value.dart';
import 'package:sven_hr/dao/vacation_type.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/models/response/approval_inbox_attachments_response.dart';
import 'package:sven_hr/utilities/app_theme.dart';
import 'package:sven_hr/utilities/constants.dart';

class MultiSelectionLOVListView extends StatefulWidget {
  List<LovValue>? lovs;

  MultiSelectionLOVListView({@required this.lovs});

  @override
  _MultiSelectionLOVListViewState createState() =>
      _MultiSelectionLOVListViewState();
}

class _MultiSelectionLOVListViewState extends State<MultiSelectionLOVListView> {
  List<String> listofSelected = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.send,
            color: ModernTheme.backgroundColor,
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
        width: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.lovs![index].isSelected = !widget.lovs![index].isSelected;
                setState(() {});
              },
              child: Container(
                color: widget.lovs![index].isSelected
                    ? AppTheme.kPrimaryColor.withOpacity(0.2)
                    : null,
                child: Row(
                  children: <Widget>[
                    Checkbox(          activeColor: ModernTheme.gradientEnd,

                        value: widget.lovs![index].isSelected,
                        onChanged: (s) {
                          widget.lovs![index].isSelected =
                              !widget.lovs![index].isSelected;
                          if (widget.lovs![index].isSelected) {
                            listofSelected.add(widget.lovs![index].row_id);
                          } else {
                            listofSelected.remove(widget.lovs![index].row_id);
                          }
                          setState(() {
                            print(listofSelected);
                          });
                        }),
                    Text(widget.lovs![index].display)
                  ],
                ),
              ),
            );
          },
          itemCount: widget.lovs!.length,
        ),
      ),
    );
  }
}

class MultiSelectionTypeListView extends StatefulWidget {
  List<VacationType>? types;

  MultiSelectionTypeListView({@required this.types});

  @override
  _MultiSelectionTypeListViewState createState() =>
      _MultiSelectionTypeListViewState();
}

class _MultiSelectionTypeListViewState
    extends State<MultiSelectionTypeListView> {
  List<String> listofSelected = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.send,
            color: ModernTheme.backgroundColor,
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
        width: 180,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                widget.types![index].isSelected =
                    !widget.types![index].isSelected;
                setState(() {});
              },
              child: Container(
                color: widget.types![index].isSelected
                    ? AppTheme.kPrimaryColor.withOpacity(0.2)
                    : null,
                child: Row(
                  children: <Widget>[
                    Checkbox(          activeColor: ModernTheme.gradientEnd,

                        value: widget.types![index].isSelected,
                        onChanged: (s) {
                          widget.types![index].isSelected =
                              !widget.types![index].isSelected;
                          if (widget.types![index].isSelected) {
                            listofSelected.add(widget.types![index].row_id);
                          } else {
                            listofSelected.remove(widget.types![index].row_id);
                          }
                          setState(() {
                            print(listofSelected);
                          });
                        }),
                    Text(widget.types![index].name)
                  ],
                ),
              ),
            );
          },
          itemCount: widget.types!.length,
        ),
      ),
    );
  }
}

class AttachmentsListView extends StatefulWidget {
  List<String>? paths;

  AttachmentsListView({@required this.paths});

  @override
  _AttachmentsListViewState createState() => _AttachmentsListViewState();
}

class _AttachmentsListViewState extends State<AttachmentsListView> {
  List<String> listofSelected = [];

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
        width: MediaQuery.of(context).size.width / 2,
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
                          widget.paths!.removeAt(index);
                        });
                      },
                    ),
                    Flexible(child: Text(widget.paths![index].split('/').last))
                  ],
                ),
              ),
            );
          },
          itemCount: widget.paths!.length,
        ),
      ),
    );
  }
}

class ApprovalInboxAttachmentsListView extends StatefulWidget {
  List<ApprovalInboxAttachmentsResponse>? attachmentsList;

  ApprovalInboxAttachmentsListView({this.attachmentsList});

  @override
  _ApprovalInboxAttachmentsListViewState createState() =>
      _ApprovalInboxAttachmentsListViewState(attachmentsList!);
}

class _ApprovalInboxAttachmentsListViewState
    extends State<ApprovalInboxAttachmentsListView> {
  List<ApprovalInboxAttachmentsResponse>? attachmentsList;
  bool showSpinner = false;

  _ApprovalInboxAttachmentsListViewState(this.attachmentsList);
  ApprovalInboxController? _approvalInboxController;

  void downLoadFile(
    String attachId,
    String attachName,
  ) async {
    setState(() {
      showSpinner = true;
    });
    _approvalInboxController = ApprovalInboxController();

    await _approvalInboxController
        !.downloadFile(
      attachId,
      attachName,
    )
        .then((value) {
      setState(() {
        if (value.compareTo(Const.SYSTEM_SUCCESS_MSG) == 0) {
          ToastMessage.showSuccessMsg(AppTranslations.of(context)
              !.text(Const.LOCALE_KEY_DOWNLOAD_FINISHED));
        } else {
          ToastMessage.showErrorMsg(AppTranslations.of(context)!.text(value));
        }
        print(value);
      });
    });

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: ModernTheme.backgroundColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: ModernTheme.accentColor,
          ),
          tooltip: 'close',
          hoverColor: ModernTheme.accentColor.withOpacity(0.7),
          splashColor: ModernTheme.accentColor,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        ),
      ],
      content: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [ModernTheme.gradientStart, ModernTheme.gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    attachmentsList![index].attachment_name,
                    style: TextStyle(color: ModernTheme.textColor),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.download_outlined,
                      color: ModernTheme.accentColor,
                    ),
                    tooltip: 'Download',
                    hoverColor: ModernTheme.accentColor.withOpacity(0.7),
                    splashColor: ModernTheme.accentColor,
                    onPressed: () {
                      downLoadFile(
                        attachmentsList![index].attachment_rowId,
                        attachmentsList![index].attachment_name,
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: attachmentsList!.length,
          ),
        ),
      ),
    );
  }

}
